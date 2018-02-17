library(shiny)
library(googleway)
library(geosphere)
library(dplyr)
library(tidyr)
library(getopt)
library(jsonlite)
library(httr)
library(lubridate)

ui <- fluidPage(
  titlePanel('Hackcity 2018 project - PubCrawlR'),
  google_mapOutput(outputId = "map", height = "800px")
)

shinyApp(ui, server)
