#### Preamble ####
# Purpose: Tests the finalized data sets
# Author: Inessa De Angelis
# Date: 18 July 2023
# Contact: inessa.deangelis@mail.utoronto.ca 
# License: MIT
# Pre-requisites
  # 02-coded_data_cleaning.R

#### Workspace setup ####
library(tidyverse)
library(validate)

#### Read in the coded cleaned data sets ####
# Read in the cleaned McKenna data # 
finalized_mckenna_data <-
  read_csv(here::here(
    "~/Desktop/Final Paper/Outputs/Data/finalized_mckenna_data.csv"),
    show_col_types = FALSE
  )

# Read in the cleaned May data #
finalized_may_data <- 
  read_csv(here::here ("~/Desktop/Final Paper/Outputs/Data/finalized_may_data.csv"),
           show_col_types = FALSE
  )

# Read in the cleaned Collins data #
finalized_collins_data <- 
  read_csv(here::here ("~/Desktop/Final Paper/Outputs/Data/finalized_collins_data.csv"),
           show_col_types = FALSE
  )

#### Check the coded and cleaned McKenna data set ####
# Check variable type #
# Code referenced from: https://tellingstorieswithdata.com/09-clean_and_prepare.html#checking-and-testing #
rules <- validator(
  is.integer(ID),
  is.character(name_of_politician),
  is.character(tweet_text),
  is.character(username),
  is.character(name),
  is.character(bio),
  is.character(severity_of_harassment),
  is.character(type_of_account),
  severity_of_harassment %in% c("Positive", "Neutral", "Questioning Authority", "Name-calling/Gender insults", "Vicious language", "Credible threats", "Hate speech"),
  type_of_account %in% c("Personal", "Professional", "Bots", "Spammers", "Anonymous", "Suspended/deleted")
)

out <-
  confront(finalized_mckenna_data, rules)

summary(out)

#### Check the coded and cleaned May data set ####
# Check variable type #
rules <- validator(
  is.integer(ID),
  is.character(name_of_politician),
  is.character(tweet_text),
  is.character(username),
  is.character(name),
  is.character(bio),
  is.character(severity_of_harassment),
  is.character(type_of_account),
  severity_of_harassment %in% c("Positive", "Neutral", "Questioning Authority", "Name-calling/Gender insults", "Vicious language", "Credible threats", "Hate speech"),
  type_of_account %in% c("Personal", "Professional", "Bots", "Spammers", "Anonymous", "Suspended/deleted")
)

out <-
  confront(finalized_may_data, rules)

summary(out)

#### Check the coded and cleaned Collins data set ####
# Check variable type #
rules <- validator(
  is.integer(ID),
  is.character(name_of_politician),
  is.character(tweet_text),
  is.character(username),
  is.character(name),
  is.character(bio),
  is.character(severity_of_harassment),
  is.character(type_of_account),
  severity_of_harassment %in% c("Positive", "Neutral", "Questioning Authority", "Name-calling/Gender insults", "Vicious language", "Credible threats", "Hate speech"),
  type_of_account %in% c("Personal", "Professional", "Bots", "Spammers", "Anonymous", "Suspended/deleted")
)

out <-
  confront(finalized_collins_data, rules)

summary(out)
