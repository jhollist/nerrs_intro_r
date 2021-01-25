# Time Series
################################################################################
# Load up packages in R session

library(ggplot2)
library(dplyr)
library(readr)
library(plotly)
library(lubridate)
library(stringr)
library(tidyr)
library(lubridate)

ne_nerrs_wq <- read_csv("ne_nerrs_wq_2020.csv", guess_max = 600000)