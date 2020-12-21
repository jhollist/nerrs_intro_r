# Floating point math

1.0 == 1.0000000000000001

# Rounding in R

round(3.5)
round(2.5)

# The data frame

my_df <- data.frame(names = c("joe", "jeny", "bob"),
                    age = c(36, 27, 44),
                    knows_r = c(FALSE, TRUE, TRUE),
                    stringsAsFactors = FALSE)
str(my_df)
View(my_df)

# Accessing columns and rows in a data frame
mean(my_df$age)
my_df[,2]
my_df[2,]
my_df[2,2]

# Reading in data from a CSV
ne_nerrs_2020 <- read.csv("ne_nerrs_wq_2020.csv")
library(readr)
ne_nerrs_2020 <- read_csv("ne_nerrs_wq_2020.csv", guess_max = 656033)

# Reading in data from excel
# Don't forget to install readxl package
library(readxl)
ne_nerrs_2020_xl <- read_excel("ne_nerrs_wq_2020.xlsx", guess_max = 600000)

# Example column name: Weight(kg) weight_kg

# Working with dplyr

# Load up needed packages

library(palmerpenguins)
library(dplyr)

# Selecting columns

penguin_bill <- select(penguins, bill_depth_mm, bill_length_mm)
penguin_bill

penguin_bill_piped <- penguins %>% select(bill_depth_mm, bill_length_mm)
penguin_bill_piped

# Filtering rows
idx <- penguins

penguin_bill_gentoo_adelie <- penguins %>% 
  select(species, bill_depth = bill_depth_mm, bill_length = bill_length_mm) %>% 
  filter(species != "Gentoo") %>%
  filter(bill_depth <= 18)
penguin_bill_gentoo_adelie
View(penguin_bill_gentoo_adelie)

# Example
read_csv("ne_nerr.csv") %>%
  select() %>%
  filter()

# Start next week with pipe and pipe alternatives
# Intermediate steps
p1 <- select(penguins, species, bill_depth = bill_depth_mm, bill_length = bill_length_mm)
p2 <- filter(p1, species != "Gentoo")
p3 <- filter(p2, bill_depth <= 18)

# Nested function
p_nested <- select(filter(filter(penguins, bill_depth_mm <= 18), 
                          species != "Gentoo"), 
                   species, bill_depth = bill_depth_mm, bill_length = bill_length_mm) 

# mutate 
penguin_ratio <- penguins %>% 
  select(species, bill_depth = bill_depth_mm, bill_length = bill_length_mm) %>% 
  filter(species != "Gentoo") %>%
  filter(bill_depth <= 18) %>%
  mutate(bill_ratio = bill_depth/bill_length) %>%
  mutate(random_number = rnorm(89))
penguin_ratio

penguin_case_when <- penguins %>% 
  select(species, bill_depth = bill_depth_mm, bill_length = bill_length_mm) %>% 
  filter(species != "Gentoo") %>%
  filter(bill_depth <= 18) %>%
  mutate(bill_ratio = case_when(species == "Chinstrap" ~
                                  bill_depth/bill_length,
                                species == "Adelie" ~
                                  bill_length/bill_depth,
                                TRUE ~ bill_length))

# group_by and summarize
species_summary <- penguins %>%
  select(species, bill_depth = bill_depth_mm, bill_length = bill_length_mm) %>% 
  filter(species != "Gentoo") %>%
  filter(bill_depth <= 18) %>%
  group_by(species) %>%
  summarize(mean_depth = mean(bill_depth),
            sd_depth = sd(bill_depth))
species_summary
  
penguin_grouped_mutate <- penguins %>%
  group_by(species) %>%
  mutate(mean_depth = mean(bill_depth_mm, na.rm = TRUE)) %>%
  ungroup() %>%
  mutate(depth_anomaly = bill_depth_mm - mean_depth) %>%
  select(species, mean_depth, depth_anomaly, bill_depth_mm)
penguin_grouped_mutate

# left join
left_table <- data.frame(left_id = 1:6, 
                         names = c("Bob", "Sue", "Jeff", "Alice", "Joe", "Betty"))
right_table <- data.frame(right_id = 1:5, 
                          left_id = c(2,1,3,6,7), 
                          age = c(17,26,45,32,6),
                          height = c(64, 70, 72.5, 61, 75),
                          weight = c(125, 175, 210, 120, 235)) 
left_right_table <- left_join(left_table, right_table)

# Pivoting
# Wide to Long format
left_right_table_long <- pivot_longer(data = left_right_table, 
                                      cols = c("age", "height", "weight"), 
                                      names_to = "parameters",
                                      values_to = "values")
left_right_table_long

# Long to Wide format
left_right_table_wide <- pivot_wider(data = left_right_table_long,
                                     names_from = "parameters",
                                     values_from = "values")




