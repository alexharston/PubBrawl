library(shiny)
library(googleway)
library(geosphere)
library(dplyr)
library(tidyr)
library(getopt)
library(jsonlite)
library(httr)
library(lubridate)

# ui <- fluidPage(
#   titlePanel('HackCity 2018 project - PubCrawlR'),
#   google_mapOutput(outputId = "map", height = "800px")
#   
# )

# ui <- fluidPage(theme = "bootstrap.css",
#     titlePanel('HackCity 2018 project - PubCrawlR'),
#     google_mapOutput(outputId = "map", height = "800px"),
#     headerPanel("PubCrawlR"),
# 
#     mainPanel(plotOutput())
# )

ui <- fluidPage(
  
  fluidRow(
    column(8, align="center",
      
  
  
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
      font-size:48pt;
      font-weight:600;
      color: red;
      text-align: center;
      }

      body {
        background-color: #f1c40f;
      }
  
    "))
  ),

  # titlePanel('pubcRawl'),
  
  headerPanel("pubcRawl"),
  
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
  
  google_mapOutput(outputId = "map", height = "600px", width="80%")
)
)
)
shinyApp(ui, server)
