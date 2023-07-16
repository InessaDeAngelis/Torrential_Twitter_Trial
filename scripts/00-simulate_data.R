#### Preamble ####
# Purpose: Simulates severity of harassment and type of account 
# Author: Inessa De Angelis
# Date: 9 July 2023
# Contact: inessa.deangelis@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(testthat)

#### Data Expectations ####
# Severity of harassment will vary on a 7-point scale from positive to hate speech 
# Type of account will vary from Personal, Professional, Bots, Spammers, and Anonymous 
# The more severe forms of harassment will come from Personal and Suspended/Deleted accounts 
# Harassing Tweets are more likely to be categorized as "name-calling", "gender-based insults", and/or "vicious language"
# Personal accounts that send Tweets containing mid to high levels of harassment on the 7-point scale are likely to belong to people who support the Conservative Party or People's Party

#### Simulate varying harassment on the 7-point scale ####
set.seed(416)

num_people <- 1000

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

num_people <- 1000
type_of_account <- tibble(
  person = 1:num_people,
  account_type = sample(c("Personal", "Professional", "Bot", "Spammer", "Anonymous", "Suspended/Deleted"), size = num_people, replace = TRUE),
)
type_of_account 

# Count number of types of accounts #
type_of_account |>
  count(account_type)

# The more severe forms of harassment will come from Personal and Suspended/Deleted accounts #
set.seed(416)

simulated_data <- tibble(
  Tweet = 1:1000,
  severity_of_harassment =
    sample(x = c("Credible Threats", "Hate Speech"), 
           size = 1000, 
           replace = TRUE, 
           prob = c(0.6, 0.4)), 
  account_type =
    sample(x = c("Personal", "Suspended/Deleted"), 
           size = 1000, 
           replace = TRUE, 
           prob = c(0.7, 0.3))
)
simulated_data 

# Harassing Tweets are more likely to be categorized as "name-calling", "gender-based insults", and/or "vicious language"
set.seed(416)

simulated_data <- tibble(
  Tweet = 1:1000,
  severity_of_harassment =
    sample(x = c("Name-calling", "Gender-based insults", "Vicious language"), 
           size = 1000, 
           replace = TRUE, 
           prob = c(0.5, 0.3, 0.2)), 
  account_type =
    sample(x = c("Personal", "Professional", "Bot"), 
           size = 1000, 
           replace = TRUE, 
           prob = c(0.6, 0.3, 0.1))
)
simulated_data

# Personal accounts that send harassing Tweets are likely to be from CPC/PPC supporters #
set.seed(416)
personal_accounts <- tibble(
  Account = 1:1000,
  severity_of_harassment =
    sample(x = c("Questioning Authority", "Name-calling/Gender-based insults"), 
           size = 1000, 
           replace = TRUE, 
           prob = c(0.6, 0.4)), 
  party_identification =
    sample(x = c("Conservative", "People's Party"),
    size = 1000,
  replace = TRUE,
  prob = c(0.6, 0.4))
)
personal_accounts

#### Data Validation ####
# Check that severity of harassment range from positive to hate speech #
# Stopifnot code referenced from: https://tellingstorieswithdata.com/12-ijalm.html
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

stopifnot(
  class(harassing_tweets$severity_of_harassment) == "character",
  class(harassing_tweets$person) == "integer",
  all(complete.cases(harassing_tweets)),
  nrow(harassing_tweets) == 1000
)

# Check that type of accounts ranges from personal to suspended/deleted #
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

stopifnot(
  class(type_of_account$account_type) == "character",
  class(type_of_account$person) == "integer",
  all(complete.cases(type_of_account)),
  nrow(type_of_account) == 1000
)

# Check severity of harassment, type of account, and Tweets #
stopifnot(
  class(simulated_data$severity_of_harassment) == "character",
  class(simulated_data$account_type) == "character",
  class(simulated_data$Tweet) == "integer",
  all(complete.cases(simulated_data)),
  nrow(simulated_data) == 1000
)

# Check personal accounts / party identification #
stopifnot(
  class(personal_accounts$Account) == "integer",
  class(personal_accounts$severity_of_harassment) == "character",
  class(personal_accounts$party_identification) == "character",
  all(complete.cases(personal_accounts)),
  nrow(personal_accounts) == 1000
)

personal_accounts$severity_of_harassment |>
  unique() |>
  length() == 2

personal_accounts$party_identification |>
  unique() |>
  length() == 2
