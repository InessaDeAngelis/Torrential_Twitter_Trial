#### Preamble ####
# Purpose: Tests the cleaned data sets
# Author: Inessa De Angelis
# Date: 16 July 2023
# Contact: inessa.deangelis@mail.utoronto.ca 
# License: MIT
# Pre-requisites
  # 01-raw_data_cleaning.R
  # 02-coded_data_cleaning.R

#### Workspace setup ####
library(tidyverse)
library(testthat)

#### Read in the data sets ####
# Read in the cleaned McKenna data # 
cleaned_mckenna_data <- read.csv(here::here("~/Desktop/Final Paper/Outputs/Data/cleaned_mckenna_data.csv"))
show_col_types = FALSE

# Read in the cleaned May data #
cleaned_may_data <- read.csv(here::here("~/Desktop/Final Paper/Outputs/Data/cleaned_may_data.csv"))

# Read in the cleaned Collins data #
cleaned_collins_data <- read.csv(here::here("~/Desktop/Final Paper/Outputs/Data/cleaned_collins_data.csv"))

#### Check that the raw McKenna data set is ready to be coded ####
# Code referenced from: https://tellingstorieswithdata.com/12-ijalm.html 
test_that("check class" , {
  expect_type(cleaned_mckenna_data$Text, "character")
  expect_type(cleaned_mckenna_data$Name, "character")
  expect_type(cleaned_mckenna_data$Username, "character")
  expect_type(cleaned_mckenna_data$Bio, "character")
  expect_type(cleaned_mckenna_data$Location, "character")
  expect_type(cleaned_mckenna_data$Followers, "integer")
  expect_type(cleaned_mckenna_data$Following, "integer")
  expect_type(cleaned_mckenna_data$URL, "character")
})

test_that("Check number of observations is correct", {
  expect_equal(nrow(cleaned_mckenna_data), 500)
})

#### Check that the raw May data set is ready to be coded ####
test_that("check class" , {
  expect_type(cleaned_may_data$Text, "character")
  expect_type(cleaned_may_data$Name, "character")
  expect_type(cleaned_may_data$Username, "character")
  expect_type(cleaned_may_data$Bio, "character")
  expect_type(cleaned_may_data$Location, "character")
  expect_type(cleaned_may_data$Followers, "integer")
  expect_type(cleaned_may_data$Following, "integer")
  expect_type(cleaned_may_data$URL, "character")
})

test_that("Check number of observations is correct", {
  expect_equal(nrow(cleaned_may_data), 500)
})

#### Check that the raw Collins data set is ready to be coded ####
test_that("check class" , {
  expect_type(cleaned_collins_data$Text, "character")
  expect_type(cleaned_collins_data$Name, "character")
  expect_type(cleaned_collins_data$Username, "character")
  expect_type(cleaned_collins_data$Bio, "character")
  expect_type(cleaned_collins_data$Location, "character")
  expect_type(cleaned_collins_data$Followers, "integer")
  expect_type(cleaned_collins_data$Following, "integer")
  expect_type(cleaned_collins_data$URL, "character")
})

test_that("Check number of observations is correct", {
  expect_equal(nrow(cleaned_collins_data), 13)
})