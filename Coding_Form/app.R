#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Code referenced from: https://deanattali.com/2015/06/14/mimicking-google-form-shiny/ 
#

library(shiny)

# Define UI for application that codes data
shinyApp(
ui <- fluidPage(

    # Application title
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
                  c("1", "2", "3", "4", "5")),
      actionButton("submit", "Submit", class = "btn-primary")
    )
    ),
server = function(input, output, session) {
}
)
