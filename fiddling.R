library(cowplot)

loadd(mobility_plots)

mobility_plots[["NJ"]]

p1 <- mobility_plots[["NJ"]]
p2 <- mobility_plots[["NY"]]
legend <- get_legend(p1)
p1 <- p1 + theme(legend.position = "none")
p2 <- p2 + theme(legend.position = "none")

# THIS
plot_grid(plot_grid(p1, p2, p1, p2, ncol = 2),
          plot_grid(NULL, legend, ncol = 1))

plot_grid(plot_grid(p1), plot_grid(NULL, legend, ncol = 1))



legend <- get_legend(mobility_plots[[1]])
mobility_plots_no_labels <- mobility_plots %>%
  map(~ .x + theme(legend.position = "none", axis.title = element_blank()))
#main_plot <- plot_grid(plotlist = mobility_plots_no_labels[1:10], ncol = 4)
#plot <- plot_grid(main_plot, plot_grid(NULL, legend, ncol = 1))


main_plot <- plot_grid(plotlist = mobility_plots_no_labels[1:10], ncol = 4)
#plot <- plot_grid(main_plot, plot_grid(NULL, legend, ncol = 1))

plot <- plot_grid(
  #plot_grid(plotlist = mobility_plots_no_labels[1:10], ncol = 4),
  main_plot,
  plot_grid(plot_grid(NULL, legend, ncol = 1)),
  rel_widths = c(1, 0.3)
)

plot

library(grid)
library(gridExtra)
x_label <- textGrob("Date")
y_label <- textGrob("Percent change", rot = 90)
grid.arrange(plot, left = y_label, bottom = x_label)



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

