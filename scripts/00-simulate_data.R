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
#Severity of harassment will vary on a 7-point scale from name-calling to hate speech and include positive and neutral
#Type of account will vary from Personal, Professional, Bots, Spammers, and Anonymous 
#The more severe forms of harassment will come from Personal and Anonymous accounts 
#Harassing Tweets are more likely to be "name-calling", "gender-based insults", and/or "vicious language"

#### Simulate varying harassment on the 7-point scale ####
set.seed(416)

num_people <- 2000

harassing_tweets <- tibble(
  person = 1:num_people,
  severity_of_harassment = sample(c("Positive", "Neutral", "Name-calling", "Gender-based_insults", "Vicious_language", "Credible_threats", "Hate_Speech"), size = num_people, replace = TRUE),
)
harassing_tweets

#### Simulate varying types of accounts ####
set.seed(416)

num_people <- 2000
type_of_account <- tibble(
  person = 1:num_people,
  account_type = sample(c("Personal", "Professional", "Bot", "Spammer", "Anonymous"), size = num_people, replace = TRUE),
)
type_of_account 

#The more severe forms of harassment will come from Personal and Anonymous accounts 
set.seed(416)

simulated_data <- tibble(
  unit = 1:2000,
  severity_of_harassment =
    sample(x = c("Credible Threats", "Hate Speech"), 
           size = 2000, 
           replace = TRUE, 
           prob = c(0.3, 0.7)), 
  account_type =
    sample(x = c("Personal", "Anonymous"), 
           size = 2000, 
           replace = TRUE, 
           prob = c(0.4, 0.6))
)
simulated_data 


#Harassing Tweets are more likely to be "name-calling", "gender-based insults", and/or "vicious language"
