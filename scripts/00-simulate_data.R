#### Preamble ####
# Purpose: Simulates severity of harassment and type of account 
# Author: Inessa De Angelis
# Date: 9 July 2023
# Contact: inessa.deangelis@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Data Expectations ####
# Severity of harassment will vary on a 7-point scale from name-calling to hate speech and include positive and neutral
# Type of account will vary from Personal, Professional, Bots, Spammers, and Anonymous 
# The more severe forms of harassment will come from Personal and Anonymous accounts 
# Harassing Tweets are more likely to be categorized as "name-calling", "gender-based insults", and/or "vicious language"

#### Simulate varying harassment on the 7-point scale ####
set.seed(416)

num_people <- 2000

harassing_tweets <- tibble(
  person = 1:num_people,
  severity_of_harassment = sample(c("Positive", "Neutral", "Name-calling", "Gender-based insults", "Vicious language", "Credible threats", "Hate speech"), size = num_people, replace = TRUE),
)
harassing_tweets

# Count number of Tweets for each of the 7 categories #
harassing_tweets |>
count(severity_of_harassment) 

#### Simulate varying types of accounts ####
set.seed(416)

num_people <- 2000
type_of_account <- tibble(
  person = 1:num_people,
  account_type = sample(c("Personal", "Professional", "Bot", "Spammer", "Anonymous", "Suspended/Deleted"), size = num_people, replace = TRUE),
)
type_of_account 

# Count number of types of accounts #
type_of_account |>
  count(account_type)

# The more severe forms of harassment will come from Personal and Anonymous accounts #
set.seed(416)

simulated_data <- tibble(
  Tweet = 1:2000,
  severity_of_harassment =
    sample(x = c("Credible Threats", "Hate Speech"), 
           size = 2000, 
           replace = TRUE, 
           prob = c(0.6, 0.4)), 
  account_type =
    sample(x = c("Personal", "Anonymous"), 
           size = 2000, 
           replace = TRUE, 
           prob = c(0.7, 0.3))
)
simulated_data 

# Harassing Tweets are more likely to be categorized as "name-calling", "gender-based insults", and/or "vicious language"
set.seed(416)

simulated_data <- tibble(
  Tweet = 1:2000,
  severity_of_harassment =
    sample(x = c("Name-calling", "Gender-based insults", "Vicious language"), 
           size = 2000, 
           replace = TRUE, 
           prob = c(0.5, 0.3, 0.2)), 
  account_type =
    sample(x = c("Personal", "Professional", "Bot"), 
           size = 2000, 
           replace = TRUE, 
           prob = c(0.6, 0.3, 0.1))
)
simulated_data

#### Data Validation ####

# Check that severity of harassment range from positive to hate speech #
class(harassing_tweets$severity_of_harassment) == "character"
sum(!(harassing_tweets$severity_of_harassment) %in%
      c("Positive",
        "Neutral",
        "Name-calling",
        "Gender-based insults",
        "Vicious language",
        "Credible threats",
        "Hate speech",
        NA)) == 0

harassing_tweets$severity_of_harassment |>
  unique() |>
  length() == 7

# Check that type of accounts ranges from personal to anonymous #
class(type_of_account$account_type) == "character"
sum(!(type_of_account$account_type) %in%
      c("Personal",
        "Professional",
        "Bot",
        "Spammer",
        "Anonymous",
        "Suspended/Deleted",
        NA)) == 0

type_of_account$account_type |>
  unique() |>
  length() == 6