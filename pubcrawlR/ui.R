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

      body {
        background-color: #f1c40f;
      }

    "))
  ),

  # titlePanel('pubcRawl'),
  headerPanel("pubcRawl"),
  google_mapOutput(outputId = "map", height = "800px")
)
    
shinyApp(ui, server)
