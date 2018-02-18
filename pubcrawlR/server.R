server <- function(input, output, session){
 
  #somevariable <- NobbysFunction(){}

  # Define API key
  key <- 'AIzaSyAa55bTPXC1akgwWNm61KT43AsmwI9NZuY'

  
  # Test case
  # Start location
  x.start <- 51.534186
  y.start <- -0.138886
  
  # End location
  x.end <- 51.517647
  y.end <- -0.119974
  
  df <- data.frame(id = 1, polyline = encode_pl(lat = c(x.start, x.end), lon = c(y.start, y.end)))
  #pubs <- findPubs(x.start, y.start, x.end, y.end, key)
  
  output$map <- renderGoogle_map({
    google_map(data = pubs, search_box = F) %>%
      add_markers(lat = 'lat', lon = 'lng', info_window = 'pub_name') %>%
      add_polylines(data = df, polyline = 'polyline', stroke_weight = 9) 
      #add_drawing(drawing_modes = c('circle')) 
  })
  
  observeEvent(input$map_map_click, {
    print(input$map_map_click)
  })
} 