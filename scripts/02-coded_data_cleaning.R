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
finalized_mckenna_data <-
finalized_mckenna_data |>
select(
  tweet_text,
  username,
  name,
  bio,
  severity_of_harassment,
  type_of_account,
  ) 
head(finalized_mckenna_data)

# Add ID column #
# Code referenced from: https://www.statology.org/dplyr-add-column/ #
finalized_mckenna_data <-
finalized_mckenna_data |>
  mutate(ID=c(1:500),
         .before=tweet_text) |>
  select(ID, tweet_text, username, name, bio, severity_of_harassment, type_of_account) 

# Case match severity of harassment #
finalized_mckenna_data <- 
  finalized_mckenna_data |>
  mutate("severity_of_harassment" = case_when(
    severity_of_harassment == 1 ~ "Positive",
    severity_of_harassment == 2 ~ "Neutral",
    severity_of_harassment == 3 ~ "Questioning Authority",
    severity_of_harassment == 4 ~ "Name-calling/Gender insults",
    severity_of_harassment == 5 ~ "Vicious language",
    severity_of_harassment == 6 ~ "Credible threats",
    severity_of_harassment == 7 ~ "Hate speech",
  )) |>
  select(ID, tweet_text, username, name, bio, severity_of_harassment, type_of_account) 
finalized_mckenna_data

# Case match type of account #
finalized_mckenna_data <- 
  finalized_mckenna_data |>
    mutate("type_of_account" = case_when(
      type_of_account == 1 ~ "Personal",
      type_of_account == 2 ~ "Professional",
      type_of_account == 3 ~ "Bots",
      type_of_account == 4 ~ "Spammers",
      type_of_account == 5 ~ "Anonymous",
      type_of_account == 6 ~ "Suspended/deleted",
           )) |>
  select(ID, tweet_text, username, name, bio, severity_of_harassment, type_of_account) 
finalized_mckenna_data

#### Clean Elizabeth May data set ####
coded_may_data <-
  read_csv(
    file = "~/Desktop/Final Paper/Outputs/Data/Coded_May_data.csv",
    show_col_types = FALSE
  )

# Name organization #
finalized_may_data <-
  clean_names(coded_may_data)

# Select columns of interest #
finalized_may_data <-
  finalized_may_data |>
  select(
    tweet_text,
    username,
    name,
    bio,
    severity_of_harassment,
    type_of_account,
  ) 
head(finalized_may_data)

# Add ID column #
finalized_may_data <-
finalized_may_data |>
  mutate(ID=c(1:500),
         .before=tweet_text) |>
  select(ID, tweet_text, username, name, bio, severity_of_harassment, type_of_account) 
finalized_may_data

# Case match severity of harassment #
finalized_may_data <- 
  finalized_may_data |>
  mutate("severity_of_harassment" = case_when(
    severity_of_harassment == 1 ~ "Positive",
    severity_of_harassment == 2 ~ "Neutral",
    severity_of_harassment == 3 ~ "Questioning Authority",
    severity_of_harassment == 4 ~ "Name-calling/Gender insults",
    severity_of_harassment == 5 ~ "Vicious language",
    severity_of_harassment == 6 ~ "Credible threats",
    severity_of_harassment == 7 ~ "Hate speech",
  )) |>
  select(ID, tweet_text, username, name, bio, severity_of_harassment, type_of_account) 
finalized_may_data

# Case match type of account #
finalized_may_data <- 
  finalized_may_data |>
  mutate("type_of_account" = case_when(
    type_of_account == 1 ~ "Personal",
    type_of_account == 2 ~ "Professional",
    type_of_account == 3 ~ "Bots",
    type_of_account == 4 ~ "Spammers",
    type_of_account == 5 ~ "Anonymous",
    type_of_account == 6 ~ "Suspended/deleted",
  )) |>
  select(ID, tweet_text, username, name, bio, severity_of_harassment, type_of_account) 
finalized_may_data

#### Clean Laurel Collins data set ####
coded_collins_data <-
  read_csv(
    file = "~/Desktop/Final Paper/Outputs/Data/Coded_Collins_data.csv",
    show_col_types = FALSE
  )

# Name organization #
finalized_collins_data <-
  clean_names(coded_collins_data)

# Select columns of interest #
finalized_collins_data <-
finalized_collins_data |>
  select(
    tweet_text,
    username,
    name,
    bio,
    severity_of_harassment,
    type_of_account,
  ) 
head(finalized_collins_data)

# Add ID column #
finalized_collins_data <-
finalized_collins_data |>
  mutate(ID=c(1:13),
         .before=tweet_text) |>
  select(ID, tweet_text, username, name, bio, severity_of_harassment, type_of_account) 
finalized_collins_data

# Case match severity of harassment #
finalized_collins_data <- 
  finalized_collins_data |>
  mutate("severity_of_harassment" = case_when(
    severity_of_harassment == 1 ~ "Positive",
    severity_of_harassment == 2 ~ "Neutral",
    severity_of_harassment == 3 ~ "Questioning Authority",
    severity_of_harassment == 4 ~ "Name-calling/Gender insults",
    severity_of_harassment == 5 ~ "Vicious language",
    severity_of_harassment == 6 ~ "Credible threats",
    severity_of_harassment == 7 ~ "Hate speech",
  )) |>
  select(ID, tweet_text, username, name, bio, severity_of_harassment, type_of_account) 
finalized_collins_data

# Case match type of account #
finalized_collins_data <- 
  finalized_collins_data |>
  mutate("type_of_account" = case_when(
    type_of_account == 1 ~ "Personal",
    type_of_account == 2 ~ "Professional",
    type_of_account == 3 ~ "Bots",
    type_of_account == 4 ~ "Spammers",
    type_of_account == 5 ~ "Anonymous",
    type_of_account == 6 ~ "Suspended/deleted",
  )) |>
  select(ID, tweet_text, username, name, bio, severity_of_harassment, type_of_account) 
finalized_collins_data

#### Save cleaned data in CSV file format ####
write_csv(
  x = finalized_mckenna_data,
  file = "~/Desktop/Final Paper/Outputs/Data/finalized_mckenna_data.csv"
)

write_csv(
  x = finalized_may_data,
  file = "~/Desktop/Final Paper/Outputs/Data/finalized_may_data.csv"
)

write_csv(
  x = finalized_collins_data,
  file = "~/Desktop/Final Paper/Outputs/Data/finalized_collins_data.csv"
)

#### Save cleaned data in Parquet file format ####
write_parquet(x = finalized_mckenna_data,
              sink = "~/Desktop/Final Paper/Outputs/Data/finalized_mckenna_data.parquet")

write_parquet(x = finalized_may_data,
              sink = "~/Desktop/Final Paper/Outputs/Data/finalized_may_data.parquet")

write_parquet(x = finalized_collins_data,
              sink = "~/Desktop/Final Paper/Outputs/Data/finalized_collins_data.parquet")
