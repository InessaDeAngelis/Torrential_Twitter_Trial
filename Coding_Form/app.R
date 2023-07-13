#### Preamble ####
# Purpose: Creates a form with Shiny to code Tweets for severity of harassment and type of account 
# Author: Inessa De Angelis
# Date: 9 July 2023
# Contact: inessa.deangelis@mail.utoronto.ca
# License: MIT
# Prerequisites: 01-raw_data_cleaning.R (to ensure your data is ready to code via this form)
# Corequisite: CodeBook.pdf 

# This is a Shiny web application. You can run the application by clicking the 'Run App' button above.

#### Workspace set up ####
library(shiny)
library(here)

#### App design ####
# Code referenced from: https://deanattali.com/2015/06/14/mimicking-google-form-shiny/ 
# Define UI for application that codes data
shinyApp(
ui <- fluidPage(

    # Application title & form categories 
    titlePanel("Torrential Twitter Data Coding Form"),
    div(
      id = "form",
      textInput("coder_name", " Coder Name"),
      selectInput("pol_name", "Name of Politician",
                  c("Catherine McKenna", "Elizabeth May", "Laurel Collins")),
      textInput("tweet_url", "Tweet URL"),
      textInput("tweet_text", "Tweet Text"),
      textInput("username", "Username"),
      textInput("name", "Name"),
      textInput("bio", "Bio"),
      selectInput("severity", "Severity of Harassment",
                  c("1", "2", "3", "4", "5", "6", "7")),
      selectInput("account_type", "Type of Account",
                  c("1", "2", "3", "4", "5", "6")),
      actionButton("submit", "Submit", class = "btn-primary")
    )
    ),
  server <- function(input, output, session) {
}
)

# Save form outputs as a CSV file
outputDir <- (here::here("~/inessadeangelis/torrential_twitter_trial/coding_form"))

saveData <- function(data) {
  data <- t(data)
  # Create a unique file name
  fileName <- sprintf("%s_%s.csv", as.integer(Sys.time()), digest::digest(data))
  # Write the file to the local system
  write.csv(
    x = data,
    file = file.path(outputDir, fileName), 
    row.names = FALSE, quote = TRUE
  )
}
loadData <- function() {
  # Read all the files into a list
  files <- list.files(outputDir, full.names = TRUE)
  data <- lapply(files, read.csv, stringsAsFactors = FALSE) 
  # Concatenate all data together into one data.frame
  data <- do.call(rbind, data)
  data
}

#Run the app
shinyApp(ui, server)