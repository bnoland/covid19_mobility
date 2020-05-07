library(tidyverse)

# Read in and prepare data ------------------------------------------------

us_data <- read_csv(
  file = "data/Global_Mobility_Report.csv",
  col_types = cols(
    country_region_code = col_character(),
    country_region = col_character(),
    sub_region_1 = col_character(),
    sub_region_2 = col_character(),
    date = col_date(format = "%Y-%m-%d"),
    .default = col_double()
  )
)

us_data <- us_data %>%
  filter(country_region_code == "US")

# Data includes: national level, all 50 states, and DC.
regions <- us_data %>%
  pull(sub_region_1) %>%
  unique()

length(regions)

region_abbr <- c(state.abb, "DC", "US")
region_name <- c(state.name, "District of Columbia", "United States")
region_abbr_lookup <- setNames(region_abbr, region_name)

us_data <- us_data %>%
  select(-country_region_code, -country_region) %>%
  mutate(
    sub_region_1 = ifelse(is.na(sub_region_1), "United States", sub_region_1)
  ) %>%
  mutate(sub_region_1 = region_abbr_lookup[sub_region_1]) %>%
  rename(
    retail_and_recreation = retail_and_recreation_percent_change_from_baseline,
    grocery_and_pharmacy = grocery_and_pharmacy_percent_change_from_baseline,
    parks = parks_percent_change_from_baseline,
    transit_stations = transit_stations_percent_change_from_baseline,
    workplaces = workplaces_percent_change_from_baseline,
    residential = residential_percent_change_from_baseline
  )

pop_density_data <- read_csv(
  file = "data/pop_density_2010.csv",
  col_types = cols(
    region = col_character(),
    density = col_double()
  )
)

# Data includes: national level, all 50 states, and DC.
regions <- pop_density_data %>%
  pull(region) %>%
  unique()

length(regions)

pop_density_data <- pop_density_data %>%
  mutate(region = region_abbr_lookup[region])

# Note: The join gives a warning about ``region'' having different attributes in
# the two data frames. This is because ``pop_density_data$region'' has a
# ``names'' attribute.
state_level_data <- us_data %>%
  filter(is.na(sub_region_2)) %>%
  select(-sub_region_2) %>%
  rename(region = sub_region_1) %>%
  left_join(pop_density_data, by = "region")

# Some sanity checking ----------------------------------------------------

state_level_data %>%
  count(region)

state_level_data %>%
  map_df(~ sum(is.na(.x)))

# Glimpse at New Jersey data ----------------------------------------------

nj_data <- state_level_data %>%
  filter(region == "NJ") %>%
  select(-region, -density)

library(lubridate)
lockdown_date <- ymd("2020-03-21")

change_from_baseline_cols <- colnames(nj_data)[-(1:2)]

for (col in change_from_baseline_cols) {
  p <- ggplot(nj_data, aes(date, !!sym(col))) +
    geom_line() +
    geom_vline(xintercept = lockdown_date, linetype = "dotted")
  
  print(p)
}

# Load R_t data -----------------------------------------------------------

rt_data <- read_csv(
  file = "data/rt.csv",
  col_types = cols(
    date = col_date(format = "%Y-%m-%d"),
    region = col_character(),
    .default = col_double()
  )
)

rt_data %>%
  count(region)

# Data includes DC.
rt_data %>%
  filter(!(region %in% state.abb))


nj_rt_data <- rt_data %>%
  filter(region == "NJ") %>%
  select(-region)

ggplot(nj_rt_data, aes(date)) +
  geom_line(aes(y = mean), color = "red") +
  geom_ribbon(aes(ymin = lower_90, ymax = upper_90), alpha = 0.5,
              fill = "blue") +
  geom_hline(yintercept = 1) +
  geom_vline(xintercept = lockdown_date, linetype = "dotted")


nj_merged_data <- left_join(nj_rt_data, nj_data, by = "date")
nj_merged_data <- nj_merged_data %>%
  mutate(on_lockdown = (date >= lockdown_date))

ggplot(nj_merged_data, aes(retail_and_recreation, mean)) +
  geom_point()

for (col in change_from_baseline_cols) {
  p <- ggplot(nj_merged_data, aes(!!sym(col), mean)) +
    geom_point()
  
  print(p)
}


relevant_vars <- nj_merged_data %>%
  select(mean, retail_and_recreation:on_lockdown) %>%
  drop_na()

cor(relevant_vars)


ols_model <- lm(mean ~ ., data = relevant_vars)
summary(ols_model)

library(car)
vif(ols_model)
