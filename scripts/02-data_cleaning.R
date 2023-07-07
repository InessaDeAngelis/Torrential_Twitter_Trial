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
