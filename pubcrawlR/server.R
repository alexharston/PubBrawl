server <- function(input, output, session){
 
  library(data.table)
  source("R/getCrime.R")
  source("R/getRoute.R")
  source("R/wrapper.R")
  
  # Test case
  # Start location
  x.start <- 51.534186
  y.start <- -0.138886
  
  # End location
  x.end <- 51.517647
  y.end <- -0.119974
  
  df <- data.frame(id = 1, polyline = encode_pl(lat = c(x.start, x.end), lon = c(y.start, y.end)))
  pubs <- findPubs(x.start, y.start, x.end, y.end, key)
  
  google.polyline <- SelectPubsAndGetRoute(pubs = pubs,
      start.coord = start.coord,
      end.coord = end.coord,
      number_pints = 5,
      safe = "safe")
  
  # Define API key
  key <- 'AIzaSyCidFr8iYBBvsMPbal07w_PUuN6Xa0uEOA'

  
  output$map <- renderGoogle_map({
    google_map(data = pubs, search_box = F) %>%
      add_markers(lat = 'lat', lon = 'lng', info_window = 'pub_name') %>%
      add_polylines(data = df, polyline = google.polyline$polyline, stroke_weight = 9) 
      #add_drawing(drawing_modes = c('circle')) 
  })
  
  observeEvent(input$map_map_click, {
    print(input$map_map_click)
  })
} 