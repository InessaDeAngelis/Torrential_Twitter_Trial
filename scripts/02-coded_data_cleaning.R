#### Preamble ####
# Purpose: Cleans the coded Tweets data
# Author: Inessa De Angelis
# Date: 17 July 2023
# Contact: inessa.deangelis@mail.utoronto.ca
# License: MIT
# Pre-requisites
  # 01-raw_data_cleaning.R
# Note: You need to manually code the Tweets (referencing the codebook) and save them as a CSV files before running this script 

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(arrow)

#### Read in the raw data sets ####

# Read in the Catherine McKenna data set #
readr::read_csv("~/Desktop/Final Paper/Outputs/Data/Coded_McKenna_data.csv")

# Read in the Elizabeth May data set #
readr::read_csv("~/Desktop/Final Paper/Outputs/Data/Coded_May_data.csv")

# Read in the Laurel Collins data set #
readr::read_csv("~/Desktop/Final Paper/Outputs/Data/Coded_Collins_data.csv")

#### Clean Catherine McKenna data set ####
coded_mckenna_data <-
  read_csv(
    file = "~/Desktop/Final Paper/Outputs/Data/Coded_McKenna_data.csv",
    show_col_types = FALSE
  )

# Name organization #
finalized_mckenna_data <-
  clean_names(coded_mckenna_data)

# Select columns of interest #
finalized_mckenna_data =
coded_mckenna_data |>
  select(
    `Tweet text`,
    Username,
    Name,
    Bio,
    `Severity of Harassment`,
    `Type of Account`,
  )
head(finalized_mckenna_data)

# Case match #
finalized_mckenna_data <-
  finalized_mckenna_data |>
  mutate("severity of harassment" = case_when(
    `Severity of Harassment` == 1 ~ "Positive",
    `Severity of Harassment` == 2 ~ "Neutral",
    `Severity of Harassment` == 3 ~ "Questioning Authority",
    `Severity of Harassment` == 4 ~ "Name-calling/Gender insults",
    `Severity of Harassment` == 5 ~ "Vicious language",
    `Severity of Harassment` == 6 ~ "Credible threats",
    `Severity of Harassment` == 7 ~ "Hate speech"
  )) |>
  select(`Tweet text`, Username, Name, Bio, `Severity of Harassment`, `Type of Account`) |>
  mutate("type of account" = case_when(
    Type of account
    
  )) |>
  select(`Tweet text`, Username, Name, Bio, `Severity of Harassment`, `Type of Account`) |>
finalized_mckenna_data
