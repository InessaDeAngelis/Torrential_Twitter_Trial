#### Preamble ####
# Purpose: Models severity of harassment and type of account
# Author: Inessa De Angelis 
# Date: 24 July 2023
# Contact: inessa.deangelis@mail.utoronto.ca 
# License: MIT
# Pre-requisites: 
  # 01-raw_data_cleaning.R
  # 02-coded_data_cleaning.R

#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(modelsummary)

#### Read data ####
# Read in the cleaned McKenna data # 
finalized_mckenna_data <- read.csv(here::here("~/Desktop/Final Paper/Outputs/Data/finalized_mckenna_data.csv"))
show_col_types = FALSE

# Read in the cleaned May data #
finalized_may_data <- read.csv(here::here("~/Desktop/Final Paper/Outputs/Data/finalized_may_data.csv"))
show_col_types = FALSE

# Read in the cleaned Collins data #
finalized_collins_data <- read.csv(here::here("~/Desktop/Final Paper/Outputs/Data/finalized_collins_data.csv"))
show_col_types = FALSE

# Create one combined data set with all three politicians for analysis #
analysis_data <- rbind(finalized_mckenna_data, finalized_may_data, finalized_collins_data)
analysis_data
show_col_types = FALSE

#### Modeling ####
# Code referenced from: https://tellingstorieswithdata.com/13-ijaglm.html#poisson-regression 
harassment_likelihood <-
  glm(
    ID ~ severity_of_harassment,
    data = analysis_data,
    family = "poisson"
  )

summary(harassment_likelihood)


harassment_rstanarm <-
  stan_glm(
    ID ~ severity_of_harassment,
    data = analysis_data,
    family = poisson(link = "log"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 416
  )

# save model #
saveRDS(
  harassment_rstanarm,
  file = "harassment_rstanarm.rds"
)

# Summary of model #
modelsummary(
  list(
    "Harassment" = harassment_rstanarm
  )
)