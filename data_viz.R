# Need ggplot2
library(ggplot2)
library(palmerpenguins)
library(ggthemes)

penguin_gg <- ggplot(data = penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(color = species, shape = species), size = 2) +
  labs(x = "Bill Length (mm)", y = "Bill Depth (mm)",
       title = "Association Between Penguin Bill Measurements") +
  geom_smooth(aes(group = species), method = "lm") +
  theme_minimal() + 
  scale_color_discrete(name = "Penguin Species") +
  scale_shape_discrete(name = "Penguin Species")
penguin_gg


ggsave("penguin_plot.jpg", penguin_gg, dpi = 600, units = "in", width = 4, 
       height = 7)
