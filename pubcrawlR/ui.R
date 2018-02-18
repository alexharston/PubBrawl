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
library(shiny)

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
        
        headerPanel("pubBRawl"),
        
        tags$div(
          tags$p("How many stops yo?")  
        ),
        sliderInput("number_pints", "",
                    min = 0, max = 10,
                    value = 5),
        
        tags$div(
          tags$p("Castles or gutters yo?")  
        ),
        sliderInput("google_review", "",
                    min = 0, max = 5,
                    value = 3.5, step = 0.1),
        
        tags$div(
          tags$p("Do you want to get into a fight?")  
        ),
        
        actionButton("button", "Come at me mate"),
        actionButton("button", "Na play it safe"),
        actionButton("button", "Whatev"),
        
        google_mapOutput(outputId = "map", height = "600px", width="80%")
      )
  )
  
)

# Define server logic for slider examples ----
server <- function(input, output) {
  
  # Reactive expression to create data frame of all input values ----
  sliderValues <- reactive({
    
    data.frame(
      Name = c( "NumberPints",
                "GoogleReview" ),
      Value = as.character( c( input$number_pints,
                               input$google_review ) ),
      stringsAsFactors = FALSE)
    
  })
  
  # Show the values in an HTML table ----
  output$values <- renderTable({
    sliderValues()
  })
  
}


shinyApp(ui, server)
