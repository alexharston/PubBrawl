server <- function(input, output, session) {
 
  library(data.table)
  source("R/getCrime.R")
  source("R/getRoute.R")
  source("R/wrapper.R")
  source("R/pubFinder.R")
  
  # Define API key
  # key <- 'AIzaSyBBm8BH5k410AQ9lr6Rm1HrYyyI8X-gULI'
  
  # Test case
  # Start location
  x.start <- 51.534186
  y.start <- -0.138886
  
  # End location
  x.end <- 51.517647
  y.end <- -0.119974
  
  start.coord <- c(x.start, y.start)
  end.coord <- c(x.end, y.end)
  
  # Get list of pubs
  # df <- data.frame(id = 1, polyline = encode_pl(lat = c(x.start, x.end), lon = c(y.start, y.end)))
  pubs <- findPubs(x.start, y.start, x.end, y.end, key)
  
  
  # Get list of a) selected pubs and b) polyline for GoogleMaps
  google.polyline <- SelectPubsAndGetRoute(pubs = pubs,
      start.coord = start.coord,
      end.coord = end.coord,
      number_pints = 5,
      safe = "safe",
      api_key = key)

  # print(google.polyline$polyline)

  # library(sf)
  
  output$map <- renderGoogle_map({
    google_map(key = key, data = google.polyline$selectedpubs, search_box = F) %>%
      add_markers(lat = 'lat', lon = 'lng', info_window = 'pub_name') %>%
      add_polylines(data = df, polyline = google.polyline$polyline$points, stroke_weight = 9)
    # add_drawing(drawing_modes = c('circle'))
    
  })
  
  observeEvent(input$map_map_click, {
    print(input$map_map_click)
  })
} 