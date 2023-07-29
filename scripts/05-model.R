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
library(marginaleffects)
library(knitr)

#### Read data ####
# Read in the cleaned McKenna data # 
finalized_mckenna_data <-
  read_csv(
    here::here("~/Desktop/Final Paper/Outputs/Data/finalized_mckenna_data.csv"),
    show_col_types = FALSE
  )

finalized_mckenna_data

# Read in the cleaned May data #
finalized_may_data <-
  read_csv(
    here::here("~/Desktop/Final Paper/Outputs/Data/finalized_may_data.csv"),
    show_col_types = FALSE
  )

finalized_may_data

# Read in the cleaned Collins data #
finalized_collins_data <-
  read_csv(
    here::here("~/Desktop/Final Paper/Outputs/Data/finalized_collins_data.csv"),
    show_col_types = FALSE
  )

# Create one combined data set with all three politicians for analysis #
analysis_data <- rbind(finalized_mckenna_data, finalized_may_data, finalized_collins_data)
analysis_data

#### Modeling ####
# Make a analysis dataset with a binary for whether suspended or not
analysis_data_binary <- 
  analysis_data %>% 
  select(severity_of_harassment, type_of_account, name_of_politician) %>% 
  filter(name_of_politician != "Laurel Collins") %>% 
  filter(type_of_account != c("Bots", "Spammers")) %>% 
  mutate(suspended_binary = if_else(type_of_account == "Suspended/deleted",
                                    1,
                                    0))


# Code referenced from: https://tellingstorieswithdata.com/13-ijaglm.html#poisson-regression 
suspension_and_harassment <-
  glm(
    suspended_binary ~ severity_of_harassment,
    data = analysis_data_binary,
    family = "binomial"
  )

summary(suspension_and_harassment)

harassment_likelihood_predictions <-
  predictions(suspension_and_harassment) |>
  as_tibble()

harassment_likelihood_predictions |>
  mutate(was_suspended = factor(suspended_binary)) |>
  ggplot(aes(x = severity_of_harassment, y = estimate, color = was_suspended)) +
  geom_jitter(width = 0.2, height = 0.1, alpha = 0.3) +
  labs(
    x = "Number of cars that were seen",
    y = "Estimated probability it is a weekday",
    color = "Actually weekday"
  ) +
  theme_classic() +
  scale_color_brewer(palette = "Set1") +
  theme(legend.position = "bottom")
