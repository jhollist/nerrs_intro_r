# Need ggplot2
library(ggplot2)
library(palmerpenguins)

ggplot(data = penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point()
