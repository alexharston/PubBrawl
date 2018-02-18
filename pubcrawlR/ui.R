library(shiny)

library(dplyr)
library(tidyr)
library(rgdal)

library(data.table)
library(googleway)
library(geosphere)
library(getopt)
library(jsonlite)
library(httr)
library(lubridate)
library(shinythemes)

source('./R/pubFinder.R')
source('./server.R')

# Define API key
#key <- 'AIzaSyDK0rcvTeq4zig62iTFWSved_FfuKjX0xY'
key <- 'AIzaSyCVHKD81q7hEu_pAIOtJ50uzaE5GbAfNoA'
set_key(key)

# Get stations
stations <- getStations()

ui <- fluidPage(

    theme = shinytheme("united"),
  
    fluidRow(
      column(12, align="center",
      
  
  
  tags$head(
    tags$style(HTML("
      
      @import url('https://fonts.googleapis.com/css?family=Lobster');
  
      h1 {
        font-family: 'Lobster', Arial, cursive;
        font-size: 48;
        font-weight: 300;
        line-height: 1.1;
        color: #08589e;
        text-align: center;
      }

      p {
      font-family: Roboto, sans-serif;
      font-size:16pt;
      font-weight:600;
      color: #08589e;
      text-align: center;
      }

      body {
        background-color: #fef0d9;
      }

          "))
        ),

        # titlePanel('pubcRawl')
        
        headerPanel("PubBrawl"),
        
        br(),
        br(),
        
        fluidRow(
          column(width = 4,  
                 tags$div(
            tags$p("How many stops?")  
          ),
          sliderInput("number_pints", "",
                      min = 0, max = 10,
                      value = 5)
                 ),
          
          column(width = 4,
                 tags$div(
                   tags$p("Do you want to get into a fight?")  
                 ),
                 actionButton("unsafe", "Come at me mate"),
                 actionButton("safe", "Nah, play it safe"),
                 actionButton("carefree", "Whatever I'm easy")
                 ),
          
          column(width= 4, 
                 tags$div(
                   tags$p("Palaces or gutters?")  
                 ),
                 sliderInput("google_review", "",
                             min = 0, max = 5,
                             value = 3.5, step = 0.1)
                 )
        
        ),
        
  
 
  # Text input box 
  selectizeInput('start', 'Pub crawl start location', stations$Name, selected = 'Camden Town Station'),
  selectizeInput('end', 'Pub crawl end location', stations$Name, selected = 'Holborn Station'),


   br(),
   br(),
        
   #submitButton("Let's Go", icon("refresh")), 
   actionButton('go', "Let's GO!"), 
  
        br(),
        br(),
        
        google_mapOutput(outputId = "map", height = "600px", width="80%")
      )
  )
)
  

shinyApp(ui, server)
