# Need ggplot2
library(ggplot2)
library(palmerpenguins)

penguin_gg <- ggplot(data = penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(color = species, shape = species), size = 2) +
  labs(x = "Bill Length (mm)", y = "Bill Depth (mm)",
       title = "Association Between Penguin Bill Measurements") +
  geom_smooth(aes(color = species), method = "lm")
penguin_gg
