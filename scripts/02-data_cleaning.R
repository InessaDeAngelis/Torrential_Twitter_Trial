#### Preamble ####
# Purpose: Cleans the raw spreadsheets of Tweets from Catherine McKenna, Elizabeth May, and Laurel Collins
# Author: Inessa De Angelis
# Date: 7 July 2023
# Contact: inessa.deangelis@mail.utoronto.ca
# License: MIT
# Note: Data obtained from Twitter in early 2021 and stored on Inessa's computer

#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Read in the raw data sets ####

# Read in the Catherine McKenna data set #
readr::read_csv("~/Desktop/Old Twitter Data/CathMckenna.csv")

# Read in the Elizabeth May data set #
readr::read_csv("~/Desktop/Old Twitter Data/ElizabethMayMentions.csv")

# Read in the Laurel Collins data set #
readr::read_csv("~/Desktop/Old Twitter Data/LaurelMentions.csv")

#### Clean Catherine McKenna data set ####
raw_mckenna_data <-
  read_csv(
    file = "~/Desktop/Old Twitter Data/CathMckenna.csv",
    show_col_types = FALSE
  )

# Select columns of interest & filter by key words #
# Code referenced from: https://www.statology.org/filter-rows-that-contain-string-dplyr/#:~:text=Often%20you%20may%20want%20to,()%20function%20in%20Base%20R.
cleaned_mckenna_data = 
  raw_mckenna_data |>
  select(
    text,
    user_sname,
    user_description,
    user_location,
    followers,
    friends,
    tweet_url
  ) |>
  filter(grepl('environment | climate', text))

#### Clean Elizabeth May data set ####
raw_may_data <-
  read_csv(
    file = "~/Desktop/Old Twitter Data/ElizabethMayMentions.csv",
    show_col_types = FALSE
  )

# Select columns of interest & filter by key words #
cleaned_may_data = 
  raw_may_data |>
  select(
    text,
    user_sname,
    user_description,
    user_location,
    followers,
    friends,
    tweet_url
  ) |>
  filter(grepl('environment | climate', text))

#### Clean Laurel Collins data set ####
raw_collins_data <-
  read_csv(
    file = "~/Desktop/Old Twitter Data/LaurelMentions.csv",
    show_col_types = FALSE
  )

# Select columns of interest & filter by key words #
cleaned_collins_data = 
  raw_collins_data |>
  select(
    text,
    user_sname,
    user_description,
    user_location,
    followers,
    friends,
    tweet_url
  ) |>
  filter(grepl('environment | climate | pipeline', text))