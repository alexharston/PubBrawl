somevariable <- NobbysFunction(){}

server <- function(input, output){
  
  # Define API key
  key <- 'AIzaSyAa55bTPXC1akgwWNm61KT43AsmwI9NZuY'
  
  # Test case
  # Start location
  x.start <- 51.534186
  y.start <- -0.138886
  
  # End location
  x.end <- 51.517647
  y.end <- -0.119974
  
  #pubs <- findPubs(x.start, y.start, x.end, y.end, key)
  
  output$map <- renderGoogle_map({
    google_map(data = pubs, key = key, search_box = T) %>%
      add_markers(lat = 'lat', lon = 'lng', info_window = 'pub_name') %>%
      add_polylines(polyline = somevariable)
      #add_drawing(drawing_modes = c('circle')) 
  })
  
  observeEvent(input$map_circlecomplete, {
    print(input$map_circlecomplete)
  })
}
