# Need ggplot2
library(ggplot2)
library(palmerpenguins)

penguin_gg <- ggplot(data = penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point()
penguin_gg
