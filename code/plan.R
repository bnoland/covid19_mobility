
plan <- drake_plan(

# Data --------------------------------------------------------------------

  raw_us_data = load_raw_us_data(file_in("data/Global_Mobility_Report.csv")),
  us_data = make_us_data(raw_us_data),
  pop_density_data = load_population_density_data(
    file_in("data/pop_density_2010.csv")
  ),
  lockdown_data = load_lockdown_data(file_in("data/lockdown.csv")),
  state_level_data = make_state_level_data(us_data, pop_density_data,
                                           lockdown_data),
  rt_data = load_rt_data(file_in("data/rt.csv")),

# Plots -------------------------------------------------------------------

  mobility_plots = plot_mobility_changes(state_level_data, lockdown_data)
)
