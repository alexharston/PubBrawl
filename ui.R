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
library(RCurl)
library(shinythemes)

source("./R/getCrime.R")
source("./R/getRoute.R")
source("./R/wrapper.R")
source('./R/pubFinder.R')
source('./R/hospitalData.R')
source('./server.R')

# Define API key
key <- 'AIzaSyCHPeKBOeV7QrPEPppnkimSpyRFCUsVNSc'
set_key(key)

# Get stations
stations <- getStations()

# Define possible saftey choices
safety.choices <- data_frame(id = c('unsafe', 'safe', 'carefree'),
                             type = c('Come at me mate',  'Nah, play it safe', "Whatever I'm easy"))

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

        headerPanel("PubBrawl"),
        
        br(),
        br(),
        
        fluidRow(
          column(width = 4,  
                 tags$div(
            tags$p("How many stops?")  
          ),
          sliderInput("number_pints", "",
                      min = 2, max = 11,
                      value = 5)
                 ),
          
          column(width = 4,
                 tags$div(
                   tags$p("Do you want to get into a fight?")  
                 ),
                 selectizeInput('safety', '', safety.choices$type, 
                                selected = safety.choices$type[2])
                 ),
          
          column(width= 4, 
                 tags$div(
                   tags$p("Palaces or gutters?")  
                 ),
                 sliderInput("google_review", "",
                             min = 0, max = 5,
                             value = 3, step = 0.1)
                 )
        
        ),
        
  # Text input box 
  selectizeInput('start', 'Pub crawl start location', stations$Name, selected = 'Camden Town Station'),
  selectizeInput('end', 'Pub crawl end location', stations$Name, selected = 'Holborn Station'),

  br(),
  br(),
  
  # Define submit buttom      
  actionButton('go', "Let's GO!"), 
  
  # Google map    
  br(),
  br(),
  google_mapOutput(outputId = "map", height = "600px", width="80%"),
  
  # Hospital string
  br(),
  br(),
  textOutput("hospital_str"),
  br(),
  br()
  )
 )
)
  
shinyApp(ui, server)
