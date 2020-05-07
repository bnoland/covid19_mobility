
plan <- drake_plan(
  us_data = load_us_data(file_in("data/Global_Mobility_Report.csv")),
  pop_density_data = load_population_density_data(
    file_in("data/pop_density_2010.csv")
  ),
  lockdown_data = load_lockdown_data(file_in("data/lockdown.csv")),
  state_level_data = make_state_level_data(us_data, pop_density_data,
                                           lockdown_data),
  rt_data = load_rt_data(file_in("data/rt.csv"))
)
