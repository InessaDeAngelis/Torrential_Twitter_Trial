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
library(arrow)

#### Read in the raw data sets ####

# Read in the Catherine McKenna data set #
readr::read_csv("~/Desktop/Final Paper/Inputs/Data/CathMckenna.csv")

# Read in the Elizabeth May data set #
readr::read_csv("~/Desktop/Final Paper/Inputs/Data/ElizabethMayMentions.csv")

# Read in the Laurel Collins data set #
readr::read_csv("~/Desktop/Final Paper/Inputs/Data/LaurelMentions.csv")

#### Clean Catherine McKenna data set ####
raw_mckenna_data <-
  read_csv(
    file = "~/Desktop/Final Paper/Inputs/Data/CathMckenna.csv",
    show_col_types = FALSE
  )

# Select columns of interest, filter by key words, and select 1,000 Tweets for analysis #
# Code to filter referenced from: https://www.statology.org/filter-rows-that-contain-string-dplyr/#:~:text=Often%20you%20may%20want%20to,()%20function%20in%20Base%20R.
# Code for sampling Tweets referenced from: https://tellingstorieswithdata.com/11-eda.html

cleaned_mckenna_data = 
  raw_mckenna_data |>
  select(
    text,
    user_name,
    user_sname,
    user_description,
    user_location,
    followers,
    friends,
    tweet_url
  ) |>
  filter(grepl('climate', text)) |>
  rename(
    Text = text,
    Name = user_name,
    Username = user_sname,
    Bio = user_description,
    Location = user_location,
    Followers = followers,
    Following = friends,
    URL = tweet_url 
  ) |>
  slice_sample(n = 500) 


#### Clean Elizabeth May data set ####
raw_may_data <-
  read_csv(
    file = "~/Desktop/Final Paper/Inputs/Data/ElizabethMayMentions.csv",
    show_col_types = FALSE
  )

# Select columns of interest, filter by key words, and select 1,000 Tweets for analysis #
cleaned_may_data = 
  raw_may_data |>
  select(
    text,
    user_name,
    user_sname,
    user_description,
    user_location,
    followers,
    friends,
    tweet_url
  ) |>
  filter(grepl('climate', text)) |>
  rename(
    Text = text,
    Name = user_name,
    Username = user_sname,
    Bio = user_description,
    Location = user_location,
    Followers = followers,
    Following = friends,
    URL = tweet_url 
  ) |>
  slice_sample(n = 500) 

#### Clean Laurel Collins data set ####
raw_collins_data <-
  read_csv(
    file = "~/Desktop/Final Paper/Inputs/Data/LaurelMentions.csv",
    show_col_types = FALSE
  )

# Select columns of interest & filter by key words #
cleaned_collins_data = 
  raw_collins_data |>
  select(
    text,
    user_name, 
    user_sname,
    user_description,
    user_location,
    followers,
    friends,
    tweet_url
  ) |>
  filter(grepl('climate', text)) |>
  rename(
    Text = text,
    Name = user_name,
    Username = user_sname,
    Bio = user_description,
    Location = user_location,
    Followers = followers,
    Following = friends,
    URL = tweet_url 
  )

#### Save cleaned data in CSV file format ####
write_csv(
  x = cleaned_mckenna_data,
  file = "~/Desktop/Final Paper/Outputs/Data/cleaned_mckenna_data.csv"
)

write_csv(
  x = cleaned_may_data,
  file = "~/Desktop/Final Paper/Outputs/Data/cleaned_may_data.csv"
)

write_csv(
  x = cleaned_collins_data,
  file = "~/Desktop/Final Paper/Outputs/Data/cleaned_collins_data.csv"
)

#### Save cleaned data in Parquet file format ####
# Code referenced from: https://tellingstorieswithdata.com/10-store_and_share.html
write_parquet(x = cleaned_mckenna_data,
              sink = "~/Desktop/Final Paper/Outputs/Data/cleaned_mckenna_data.parquet")

write_parquet(x = cleaned_may_data,
              sink = "~/Desktop/Final Paper/Outputs/Data/cleaned_may_data.parquet")

write_parquet(x = cleaned_collins_data,
              sink = "~/Desktop/Final Paper/Outputs/Data/cleaned_collins_data.parquet")
