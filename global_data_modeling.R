library(tidyverse)
library(lubridate)

data_dir <- "global_data"
global_data <- read_csv(
  file = file.path(data_dir, "merged_global_data.csv"),
  col_types = cols(
    region = col_character(),
    date = col_date(format = "%Y-%m-%d"),
    .default = col_double()
  )
)

sort(unique(global_data$region))

global_data <- global_data %>%
  group_by(region) %>%
  mutate(
    days_since_start = (min(date) %--% date) / days(1)
  )

global_model_full <- lm(
  R ~ region + days_since_start + retail_and_recreation + grocery_and_pharmacy + parks + transit_stations + workplaces + residential,
  data = global_data
)

car::vif(global_model_full)

summary(global_model_full)

old_par = par(mfrow=c(2, 2))
plot(global_model_full)
par(old_par)

# box_cox_results <- MASS::boxcox(global_model)
# best_lambda <- box_cox_results$x[which.max(box_cox_results$y)]
# best_lambda


explanatory_vars <- c("retail_and_recreation", "grocery_and_pharmacy", "parks",
                      "transit_stations", "workplaces", "residential")

model_list <- list()
for (ev in explanatory_vars) {
  f <- str_c("R ~ region + days_since_start +", ev)
  model <- lm(f, data = global_data)
  model_list[[ev]] <- model
}

model <- model_list[["retail_and_recreation"]]

summary(model)

old_par = par(mfrow=c(2, 2))
plot(model)
par(old_par)
