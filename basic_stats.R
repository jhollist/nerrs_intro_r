# Code for basic stats lesson
library(dplyr)
library(readr)
library(tidyr)

# Read and clean NLA data
nla_wq_all <- read_csv("https://www.epa.gov/sites/production/files/2014-10/nla2007_chemical_conditionestimates_20091123.csv")

nla_wq <- nla_wq_all %>%
  rename_all(tolower) %>% #making all names lower case beucase they are a mess!
  mutate_if(is.character, tolower) %>%
  filter(site_type == "prob_lake",
         visit_no == 1) %>%
  select(site_id, st, epa_reg, wsa_eco9, ptl, ntl, turb, chla, doc)

# Read and clean NLA sites
nla_sites <- read_csv("https://www.epa.gov/sites/production/files/2014-01/nla2007_sampledlakeinformation_20091113.csv")

nla_sites <- nla_sites %>%
  filter(VISIT_NO == 1) %>%
  select(SITE_ID, STATE_NAME, CNTYNAME, LAKE_ORIGIN, RT_NLA) %>%
  rename_all(tolower) %>% #making all names lower case because they are a mess!
  mutate_if(is.character, tolower)

# Join data and sites
nla <- left_join(nla_sites, nla_wq, by = "site_id") %>%
  filter(!is.na(ntl),
         !is.na(chla),
         !is.na(ptl))

# Univariate stats
summary(nla)
mean(nla$chla)
min(nla$chla)
sd(nla$chla)
quantile(nla$chla)

# Simple viz
hist(nla$ntl, breaks = 5)
hist(nla$ntl)
hist(log1p(nla$ntl))
plot(density(log1p(nla$ntl)))
boxplot(log1p(nla$ntl))
boxplot(log1p(nla$ntl) ~ nla$epa_reg)
# Formula notation y ~ x
plot(log1p(nla$ptl), log1p(nla$ntl))

nla_numeric <- nla %>%
  select(ntl, ptl, chla, turb)
plot(log1p(nla_numeric))

# t-test
boxplot(log1p(nla$chla) ~ nla$lake_origin)
t.test(log1p(nla$chla) ~ nla$lake_origin)

# ANOVA
boxplot(log1p(nla$chla) ~ nla$rt_nla)
nla_anova <- aov(log1p(chla) ~ rt_nla, data = nla)
nla_anova
summary(nla_anova)
