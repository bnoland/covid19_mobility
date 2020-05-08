
loadd(lockdown_data, state_level_data)

plot_mobility_changes(state_level_data, lockdown_data)

ggplot(mtcars, aes(mpg, cyl)) +
  geom_point() +
  geom_ribbon(aes(xmin = 15, xmax = Inf), alpha = 0.1, color = "black", linetype = "dashed")

l <- list(a = 1, b = 2)
x <- imap(l, function(x, i) print(x))
names(l)
names(x)

source("code/packages.R")
loadd(state_level_data)
data <- state_level_data %>%
  filter(region == "NJ")
data

change_from_baseline_cols <- colnames(state_level_data)[-c(1:2, 9:12)]

data <- data %>%
  pivot_longer(
    cols = all_of(change_from_baseline_cols),
    names_to = "type",
    values_to = "change"
  )

lockdown <- data$lockdown[[1]]
reopen <- data$reopen[[1]]

plot <- ggplot(data, aes(date, change, color = type)) +
  geom_line() +
  geom_hline(yintercept = 0, linetype = "dashed")

if (lockdown > -Inf) {
  # plot <- plot +
  #   geom_rect(aes(xmin = as_date(lockdown), xmax = as_date(reopen),
  #                 ymin = -Inf, ymax = Inf),
  #             alpha = 0.5, fill = "grey")
  
  plot <- plot +
    annotate("rect", xmin = as_date(lockdown), xmax = as_date(reopen),
             ymin = -Inf, ymax = Inf,
             alpha = 0.5, fill = "grey")
}

print(plot)





mtcars$cyl <- factor(mtcars$cyl)
mtcars$am <- factor(mtcars$am)

ggplot(mtcars) +
  geom_density(aes(x=disp, group=cyl, fill=cyl), alpha=0.6, adjust=0.75) + 
  geom_rect(data=data.frame(xmin=100, xmax=200, ymin=0, ymax=Inf), aes(xmin=xmin, xmax=xmax, ymin=ymin,ymax=ymax), fill="red", alpha=0.2) 

ggplot(mtcars) +
  geom_density(aes(x=disp, group=cyl, fill=cyl), alpha=0.6, adjust=0.75) + 
  geom_rect(aes(xmin=100, xmax=200, ymin=0,ymax=Inf), fill="red", alpha=0.2) 











library(cowplot)

loadd(mobility_plots)
mobility_plots[["NJ"]]

mobility_plots[["TX"]]

plot_grid(mobility_plots[["NJ"]], mobility_plots[["NY"]])

mobility_plots[["NE"]]

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

