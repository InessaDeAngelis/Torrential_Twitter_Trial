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
# Make an analysis dataset with a binary for whether suspended or not
analysis_data_binary <- 
  analysis_data |>
  select(severity_of_harassment, type_of_account, name_of_politician) |>
  filter(name_of_politician != "Laurel Collins") |>
  filter(type_of_account != c("Bots", "Spammers")) |> 
  mutate(suspended_binary = if_else(type_of_account == "Suspended/deleted",
                                    1,
                                    0))


# Code referenced from: https://tellingstorieswithdata.com/13-ijaglm.html#logistic-regression 
suspension_and_harassment <-
  glm(
    suspended_binary ~ severity_of_harassment + name_of_politician,
    data = analysis_data_binary,
    family = "binomial"
  )

saveRDS(suspension_and_harassment, "Outputs/model/suspension_and_harassment.rds")

summary(suspension_and_harassment)

harassment_likelihood_predictions <-
  predictions(suspension_and_harassment) |>
  as_tibble()

### Graph

harassment_likelihood_predictions |>
  mutate(was_suspended = factor(suspended_binary)) |>
  mutate(severity_of_harassment = fct_relevel(severity_of_harassment, "Positive", "Neutral", "Questioning Authority", "Name-calling/Gender insults", "Vicious language", "Credible threats", "Hate speech")) |>
  ggplot(aes(x = severity_of_harassment, y = estimate, color = was_suspended)) +
  geom_jitter(width = 0.2, height = 0.0, alpha = 0.3) +
  labs(
    x = "Severity of Harassment",
    y = "Estimated probability that an account was suspended",
    color = "Was Suspended"
  ) +
  theme_classic() +
  theme(axis.text.x = element_text(angle=45, hjust = 1, size = 10)) + 
  scale_color_brewer(palette = "Set1") +
  theme(legend.position = "bottom") +
  theme(legend.text = element_text(size = 6)) +
  theme(legend.title = element_text(size = 9)) 


### Table
just_the_estimates <-
  harassment_likelihood_predictions |>
  select(estimate, severity_of_harassment, name_of_politician) |>
  unique()

harassment_likelihood_predictions |>
  mutate(was_suspended = factor(suspended_binary)) |>
  mutate(
    severity_of_harassment = fct_relevel(
      severity_of_harassment,
      "Positive",
      "Neutral",
      "Questioning Authority",
      "Name-calling/Gender insults",
      "Vicious language",
      "Credible threats",
      "Hate speech"
    )
  ) %>%
  count(severity_of_harassment, was_suspended) |>
  pivot_wider(names_from = was_suspended,
              values_from = n) |>
  mutate(`0` = if_else(is.na(`0`), 0, `0`)) |>
  mutate(proportion_suspended = `1` / (`0` + `1`)) |>
  rename("Number not suspended" = `0`,
         "Number suspended" = `1`) |>
  left_join(just_the_estimates, by = join_by(severity_of_harassment))
  

  

slopes(suspension_and_harassment, newdata = "median")


