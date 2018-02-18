library(shiny)
library(shinysky)

library(dplyr)
library(tidyr)
library(readr)

library(googleway)
library(geosphere)
library(getopt)
library(jsonlite)
library(httr)
library(lubridate)

source('./R/pubFinder.R')
source('./server.R')

# Define API key
key <- 'AIzaSyCQRLfT4Svbb0PoG9TKH_aPJiRO6FGSh2c'
set_key(key)

ui <- fluidPage(
  
  fluidRow(
    column(12, align="center",
      
  
  
  tags$head(
    tags$style(HTML("
      
      @import url('https://fonts.googleapis.com/css?family=Lobster');
  
      h1 {
        font-family: 'Lobster', Arial, cursive;
        font-weight: 300;
        line-height: 1.1;
        color: #3498db;
        text-align: center;
      }

      p {
      font-family: Roboto, sans-serif;
      font-size:32pt;
      font-weight:300;
      color: white;
      text-align: center;
      }

      body {
        background-color: #f1c40f;
      }
  
    "))
  ),

  # titlePanel('pubcRawl'),
  
  headerPanel("PubBrawl"),
  
  tags$div(
    tags$p("Do you want to get into a fight?")  
  ),
  
  actionButton("button", "Come at me mate"),
  actionButton("button", "No"),
  actionButton("button", "I literally don't care"),
  
  tags$div(
    tags$p("Do you want to have a quality time?")  
  ),
  
  actionButton("button", "Yes"),
  actionButton("button", "No"),
  
  # Input: Simple integer interval ----
  sliderInput("integer", "How many pubs?",
              min = 2, max = 10,
              value = 1),
  
  google_mapOutput(outputId = "map", height = "600px", width="80%")
)
)
)
shinyApp(ui, server)
