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
library(zoo)

# Time Series Examples

ne_nerrs_wq <- read_csv("ne_nerrs_wq_2020.csv", guess_max = 600000) 

ne_nerrs_wq <- ne_nerrs_wq %>%
  select(site, datetimestamp:f_do_pct, ph:f_turb) %>%
  mutate(f_temp = case_when(.data$f_temp != 0 ~
                              NA_real_,
                            TRUE ~ .data$f_temp),
         f_spcond = case_when(.data$f_spcond != 0 ~
                                NA_real_,
                              TRUE ~ .data$f_spcond),
         f_sal = case_when(.data$f_sal != 0 ~
                             NA_real_,
                           TRUE ~ .data$f_sal),
         f_do_pct = case_when(.data$f_do_pct != 0 ~
                                NA_real_,
                              TRUE ~ .data$f_do_pct),
         f_ph = case_when(.data$f_ph != 0 ~
                            NA_real_,
                          TRUE ~ .data$f_ph),
         f_turb = case_when(.data$f_turb != 0 ~
                              NA_real_,
                            TRUE ~ .data$f_turb)) %>%
  filter(complete.cases(.)) %>%
  select(site, datetimestamp, temp, sal, do_pct, ph, turb) 

ne_nerrs_wq_no_time <- ne_nerrs_wq %>%
  mutate(bad_time = as.character(datetimestamp)) %>%
  select(site, bad_time, temp:turb)

# In case too many points to plot quickly
ne_nerrs_wq_no_time <- ne_nerrs_wq_no_time[1:2000,]

ne_nerrs_wq_time <- ne_nerrs_wq_no_time %>%
  mutate(date_time = ymd_hms(bad_time))

ne_nerrs_wq_time$roll_mean_temp <- rollmean(ne_nerrs_wq_time$temp,24*4, 
                                            fill = "extend")

ggplot(ne_nerrs_wq_time, aes(x = date_time, y = temp)) +
  geom_point() +
  geom_point(aes(x = date_time, y = roll_mean_temp), col = "red")

# Spatial data in R

# Vector
library(sp) # old-school
library(sf) 






