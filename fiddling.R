fish_encounters
fish_encounters %>%
  pivot_wider(names_from = station, values_from = seen)

relig_income

relig_income %>%
  pivot_longer(-religion, names_to = "income", values_to = "count")


loadd(state_level_data)

al_data <- state_level_data %>%
  filter(region == "AL")
al_data

change_from_baseline_cols <- colnames(state_level_data)[-c(1, 2, 9, 10)]

tmp <- syms(change_from_baseline_cols)

al_data_longer <- al_data %>%
  pivot_longer(all_of(change_from_baseline_cols), names_to = "type", values_to = "change")

al_data_longer


library(cowplot)


loadd(mobility_plots)
mobility_plots[["NJ"]]


plot_grid(mobility_plots[["NJ"]], mobility_plots[["NY"]])

p1 <- mobility_plots[["NJ"]]
p2 <- mobility_plots[["NY"]]
legend <- get_legend(p1)
p1 <- p1 + theme(legend.position = "none")
p2 <- p2 + theme(legend.position = "none")

# THIS
plot_grid(plot_grid(p1, p2, ncol = 1, align = "v"),
          plot_grid(NULL, legend, ncol = 1))


p1 <- ggplot(mtcars, aes(mpg, disp)) + geom_line()
plot.mpg <- ggplot(mpg, aes(x = cty, y = hwy, colour = factor(cyl))) + geom_point(size=2.5)
# Note that these cannot be aligned vertically due to the legend in the plot.mpg
ggdraw(plot_grid(p1, plot.mpg, ncol=1, align='v'))

legend <- get_legend(plot.mpg)
plot.mpg <- plot.mpg + theme(legend.position='none')
# Now plots are aligned vertically with the legend to the right
ggdraw(plot_grid(plot_grid(p1, plot.mpg, ncol=1, align='v'),
                 plot_grid(NULL, legend, ncol=1),
                 rel_widths=c(1, 0.2)))

