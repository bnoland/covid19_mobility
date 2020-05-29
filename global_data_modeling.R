library(tidyverse)

data_dir <- "global_data"
global_data <- read_csv(
  file = file.path(data_dir, "merged_global_data.csv"),
  col_types = cols(
    region = col_character(),
    date = col_date(format = "%Y-%m-%d"),
    .default = col_double()
  )
)

global_data <- global_data %>%
  drop_na()

global_model <- lm(
  R ~ region + date + retail_and_recreation + grocery_and_pharmacy + parks + transit_stations + workplaces + residential,
  data = global_data
)

summary(global_model)

old_par = par(mfrow=c(2, 2))
plot(global_model)
par(old_par)

box_cox_results <- MASS::boxcox(global_model)
best_lambda <- box_cox_results$x[which.max(box_cox_results$y)]
best_lambda
