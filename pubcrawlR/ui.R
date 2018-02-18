library(shiny)
# library(shinysky)

library(dplyr)
library(tidyr)
# library(readr)

library(data.table)
library(googleway)
library(geosphere)
library(getopt)
library(jsonlite)
library(httr)
library(lubridate)
library(shinythemes)

# source('./R/pubFinder.R')
source('./server.R')

# Define API key
key <- 'AIzaSyCVHKD81q7hEu_pAIOtJ50uzaE5GbAfNoA'
set_key(key)


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
        
        tags$div(
          tags$p("How many stops?")  
        ),
        sliderInput("number_pints", "",
                    min = 0, max = 10,
                    value = 5),
        
        br(),
        br(),
        
        tags$div(
          tags$p("Palaces or gutters?")  
        ),
        sliderInput("google_review", "",
                    min = 0, max = 5,
                    value = 3.5, step = 0.1),
        
        br(),
        br(),
        
        tags$div(
          tags$p("Do you want to get into a fight?")  
        ),
        actionButton("unsafe", "Come at me mate"),
        actionButton("safe", "Nah, play it safe"),
        actionButton("carefree", "Whatever I'm easy"),
  
        br(),
        br(),
        
        google_mapOutput(outputId = "map", height = "600px", width="80%"),
        
        br(),
        br(),
        
        submitButton("Update View", icon("refresh")), 
        
        br(),
        br()
      )
  )
)
  

shinyApp(ui, server)
