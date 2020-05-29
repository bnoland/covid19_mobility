library(tidyverse)

data_dir <- "global_data"
rt_data <- read_csv(
  file = file.path(data_dir, "global_rt.csv"),
  col_types = cols(
    `Country/Region` = col_character(),
    Date = col_date(format = "%Y-%m-%d"),
    last_updated = col_date(format = "%Y-%m-%d"),
    .default = col_double()
  )
)

rt_data <- rt_data %>%
  rename(
    region = `Country/Region`,
    date = Date
  ) %>%
  mutate(region = replace(region, region == "US", "United States")) %>%
  filter(days_infectious == 7) %>%
  select(-days_infectious, -last_updated)

rt_data

mobility_data <- read_csv(
  file = file.path(data_dir, "Global_Mobility_Report.csv"),
  col_types = cols(
    country_region_code = col_character(),
    country_region = col_character(),
    sub_region_1 = col_character(),
    sub_region_2 = col_character(),
    date = col_date(format = "%Y-%m-%d"),
    .default = col_double()
  )
)

mobility_data <- mobility_data %>%
  filter(is.na(sub_region_1) & is.na(sub_region_2)) %>%
  select(-sub_region_1, -sub_region_2, -country_region_code)

mobility_data <- mobility_data %>%
  rename(
    region = country_region,
    #region_code = country_region_code,
    retail_and_recreation
    = retail_and_recreation_percent_change_from_baseline,
    grocery_and_pharmacy = grocery_and_pharmacy_percent_change_from_baseline,
    parks = parks_percent_change_from_baseline,
    transit_stations = transit_stations_percent_change_from_baseline,
    workplaces = workplaces_percent_change_from_baseline,
    residential = residential_percent_change_from_baseline
  )

mobility_data

# TODO: Should specify countries of interest beforehand.

sort(unique(mobility_data$region))
sort(unique(rt_data$region))

merged_data <- left_join(mobility_data, rt_data, by = c("region", "date"))
merged_data

sort(unique(merged_data$region))

write_csv(merged_data, file.path(data_dir, "merged_global_data.csv"))
