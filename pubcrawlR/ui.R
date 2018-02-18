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
  # Page title
  titlePanel('Hackcity 2018 project - PubCrawlR'),
  
  # Google maps 
  mainPanel(google_mapOutput(outputId = 'map', height = '800px'))
  
  # Sidebars
  #sidebarLayout(
  #  # Text input 
  #  #sidebarPanel(selectInput('start', 'Pub crawl start', choices = '', multiple = T)),
  #  #sidebarPanel(selectizeInput('start', 'Pub crawl start', choices = '')),
  #  #sidebarPanel(select2Input('start', 'Pub crawl start', choices = 'Select a start point', type = 'input')), 
  #  #sidebarPanel(textInput('start', 'Pub crawl start', '')),
  #  #sidebarPanel(textInput.typeahead(id = 'start',
  #  #                                 placeholder = '', 
  #  #                                 local = data_frame(description = 'London'),
  #  #                                 template = HTML("<p class='des'>{{description}}</p>"),
  #  #                                 tokens = 1, valueKey = 'description')),
  #  #
  #  # Google maps 
  #  mainPanel(google_mapOutput(outputId = 'map', height = '800px'))
  #)
)

shinyApp(ui, server)
