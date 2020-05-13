
lead_vals <- 0:14

plan <- drake_plan(

# Data --------------------------------------------------------------------

  raw_us_data = load_raw_us_data(file_in("data/Global_Mobility_Report.csv")),
  us_data = make_us_data(raw_us_data),
  pop_density_data = load_population_density_data(
    # file_in("data/pop_density_2010.csv")
    file_in("data/pop_density_estimates.csv")
  ),
  lockdown_data = load_lockdown_data(file_in("data/lockdown.csv")),
  state_level_data = make_state_level_data(us_data, pop_density_data,
                                           lockdown_data),
  rt_data = load_rt_data(file_in("data/rt.csv")),

  model_data_list = make_model_data(state_level_data, rt_data, lead_vals),

# Plots -------------------------------------------------------------------

  mobility_plots = plot_mobility_changes(state_level_data),

# Models ------------------------------------------------------------------

  rf_model_list = make_random_forest_models(model_data_list, lead_vals),

# Reports -----------------------------------------------------------------

  # For display on GitHub.
  eda_report = render(
    knitr_in("eda.Rmd"),
    output_format = md_document("gfm"),
    output_file = file_out("eda.md"),
    quiet = TRUE
  )
)
