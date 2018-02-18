library(shiny)
library(googleway)
library(geosphere)
library(dplyr)
library(tidyr)
library(getopt)
library(jsonlite)
library(httr)
library(lubridate)
library(shinythemes)

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
    
    theme = shinytheme("united"),
                 
    fluidRow(
      column(8, align="center",

        tags$head(
          tags$style(HTML("

            @import url('https://fonts.googleapis.com/css?family=Lobster');

            h1 {
              font-family: 'Lobster', Arial, cursive;
              font-size:48;
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
        
        headerPanel("pubBRawl"),
        
        br(),
        br(),
        
        tags$div(
          tags$p("How many stops yo?")  
        ),
        sliderInput("number_pints", "",
                    min = 0, max = 10,
                    value = 5),
        
        br(),
        br(),
        
        tags$div(
          tags$p("Castles or gutters yo?")  
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
        actionButton("safe", "Na play it safe"),
        actionButton("carefree", "Whatev"),
  
        br(),
        br(),
        
        google_mapOutput(outputId = "map", height = "600px", width="80%"),
        
        br(),
        br(),
        
        submitButton("Update View", icon("refresh"), 
        
        br(),
        br()
      )
  )
)
)

# Define server logic for slider examples ----
server <- function(input, output, safety) {
  
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
  
  safety <- reactiveValues(data = NULL)
  
  observeEvent(input$unsafe, {
    safety  <- "unsafe"
  })
  
  observeEvent(input$safe, {
    safety  <- "safe"
  })  
  
  observeEvent(input$carefree, {
    safety  <- "carefree"
  })  
  
}


shinyApp(ui, server)
