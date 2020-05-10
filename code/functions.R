
# Data loading and preprocessing ------------------------------------------

load_raw_us_data <- function(file) {
  raw_us_data <- read_csv(
    file = file,
    col_types = cols(
      country_region_code = col_character(),
      country_region = col_character(),
      sub_region_1 = col_character(),
      sub_region_2 = col_character(),
      date = col_date(format = "%Y-%m-%d"),
      .default = col_double()
    )
  )
  
  raw_us_data <- raw_us_data %>%
    filter(country_region_code == "US")
  
  raw_us_data
}

region_abbr <- c(state.abb, "DC", "US")
region_name <- c(state.name, "District of Columbia", "United States")
region_abbr_lookup <- set_names(region_abbr, region_name)

make_us_data <- function(raw_us_data) {
  us_data <- raw_us_data %>%
    filter(country_region_code == "US") %>%
    select(-country_region_code, -country_region) %>%
    mutate(
      sub_region_1 = ifelse(is.na(sub_region_1), "United States", sub_region_1)
    ) %>%
    mutate(sub_region_1 = region_abbr_lookup[sub_region_1]) %>%
    rename(
      retail_and_recreation
        = retail_and_recreation_percent_change_from_baseline,
      grocery_and_pharmacy = grocery_and_pharmacy_percent_change_from_baseline,
      parks = parks_percent_change_from_baseline,
      transit_stations = transit_stations_percent_change_from_baseline,
      workplaces = workplaces_percent_change_from_baseline,
      residential = residential_percent_change_from_baseline
    )
  
  # Get rid of names attribute.
  names(us_data$sub_region_1) <- NULL
  
  us_data
}

load_population_density_data <- function(file) {
  pop_density_data <- read_csv(
    file = file,
    col_types = cols(
      region = col_character(),
      density = col_double()
    )
  )
  
  pop_density_data <- pop_density_data %>%
    mutate(region = region_abbr_lookup[region])
  
  # Get rid of names attribute.
  names(pop_density_data$region) <- NULL
  
  pop_density_data
}

make_state_level_data <- function(us_data, pop_density_data, lockdown_data) {
  state_level_data <- us_data %>%
    filter(sub_region_1 != "US", is.na(sub_region_2)) %>%
    select(-sub_region_2) %>%
    rename(region = sub_region_1) %>%
    left_join(pop_density_data, by = "region") %>%
    left_join(lockdown_data, by = "region") %>%
    # TODO: Ensure this works properly.
    mutate(on_lockdown = (date >= lockdown) & (date < reopen))
    #select(-lockdown, -reopen)
  
  state_level_data
}

load_rt_data <- function(file) {
  rt_data <- read_csv(
    file = file,
    col_types = cols(
      date = col_date(format = "%Y-%m-%d"),
      region = col_character(),
      .default = col_double()
    )
  )
  
  rt_data <- rt_data %>%
    group_by(region) %>%
    mutate(lagged_mean = lag(mean, 5))
  
  rt_data
}

load_lockdown_data <- function(file) {
  lockdown_data <- read_csv(
    file = file,
    col_types = cols(
      region = col_character(),
      .default = col_date(format = "%Y-%m-%d")
    )
  )
  
  lockdown_data <- lockdown_data %>%
    # TODO: Ensure this actually works properly when computing when a date
    # correponds to the lockdown period.
    mutate(
      lockdown = ifelse(is.na(lockdown), as_date(-Inf), lockdown),
      reopen = ifelse(is.na(reopen), as_date(Inf), reopen)
    ) %>%
    mutate(region = region_abbr_lookup[region])
  
  # Get rid of names attribute.
  names(lockdown_data$region) <- NULL
  
  lockdown_data
}

make_model_data <- function(state_level_data, rt_data) {
  plain_model_data <- state_level_data %>%
    left_join(rt_data, by = c("region", "date")) %>%
    drop_na()
  
  model_data_list <- list()
  model_data_list[["plain"]] <- plain_model_data
  model_data_list[["no_dc"]] <- plain_model_data %>%
    filter(region != "DC")
  model_data_list[["no_ny"]] <- plain_model_data %>%
    filter(region != "NY")
  model_data_list[["low_density"]] <- plain_model_data %>%
    filter(!(region %in% c("CT", "DC", "MA", "MD", "NJ", "RI")))
  
  model_data_list
}

# Plots -------------------------------------------------------------------

plot_mobility_changes <- function(state_level_data) {
  state_level_data_grouped <- state_level_data %>%
    group_by(region)
  
  regions <- state_level_data_grouped %>%
    group_keys() %>%
    pull(region)
  
  state_data_list <- state_level_data_grouped %>%
    group_split() %>%
    set_names(regions)
  
  change_from_baseline_cols <- colnames(state_level_data)[-c(1:2, 9:12)]
  
  # Note that purrr::imap() preserves the names of its input list.
  plots <- state_data_list %>%
    imap(function(data, region) {
      data <- data %>%
        pivot_longer(
          cols = all_of(change_from_baseline_cols),
          names_to = "type",
          values_to = "change"
        )
      
      plot <- ggplot(data, aes(date, change, color = type))
      
      lockdown <- data$lockdown[[1]]
      reopen <- data$reopen[[1]]
      
      if (lockdown > -Inf) {
        plot <- plot +
          annotate("rect", xmin = as_date(lockdown), xmax = as_date(reopen),
                   ymin = -Inf, ymax = Inf,
                   alpha = 0.5, fill = "grey")
      }
      
      plot <- plot +
        geom_line() +
        geom_hline(yintercept = 0, linetype = "dashed") +
        labs(title = region, x = "Date", y = "Percent change")
      
      plot
    })
  
  plots
}

# Models ------------------------------------------------------------------

make_random_forest_models <- function(model_data_list) {
  set.seed(42)
  
  rf_model_list <- model_data_list %>%
    map(function(model_data) {
      rf_model <- randomForest(
        # TODO: May want custom formulas as well.
        # TODO: mean vs. lagged_mean
        # mean ~ region + retail_and_recreation + grocery_and_pharmacy + parks +
        #   transit_stations + workplaces + residential + density + on_lockdown,
        lagged_mean ~ region + retail_and_recreation + grocery_and_pharmacy +
          parks + transit_stations + workplaces + residential + density +
          on_lockdown,
        importance = TRUE,
        ntree = 500,
        data = model_data
      )
      
      rf_model
    })
  
  rf_model_list
}
