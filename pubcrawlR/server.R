server <- function(input, output, session){

  # Define default stations 
  y.start <- stations@coords[grep(stations$Name, pattern = 'Camden'), 1]
  x.start <- stations@coords[grep(stations$Name, pattern = 'Camden'), 2]
  y.end <- stations@coords[grep(stations$Name, pattern = 'Holborn'), 1]
  x.end <- stations@coords[grep(stations$Name, pattern = 'Holborn'), 2]
  
  df <- data.frame(id = 1, polyline = encode_pl(lat = c(x.start, x.end), lon = c(y.start, y.end)))
  pubs <- findPubs(x.start, y.start, x.end, y.end, key)
  
  output$map <- renderGoogle_map({
    google_map(data = pubs, search_box = F) %>%
      add_markers(lat = 'lat', lon = 'lng', info_window = 'pub_name') %>%
      add_polylines(data = df, id = 'poly', polyline = 'polyline', stroke_weight = 9) 
    #  add_drawing(drawing_modes = c('rectangle')) 
  })
 
  #  
  observeEvent(input$go, {
    y.start <- stations@coords[stations$Name == input$start, 1]
    x.start <- stations@coords[stations$Name == input$start, 2]
    pubs <- findPubs(x.start, y.start, x.end, y.end, key)
    df.updated <- data.frame(id = 1, polyline = encode_pl(lat = c(x.start, x.end), lon = c(y.start, y.end)))
    print(pubs)
    google_map_update(map_id = 'map') 
  })
  
  observeEvent(input$go, {
    y.end <- stations@coords[stations$Name == input$end, 1]
    x.end <- stations@coords[stations$Name == input$end, 2]
    pubs <- findPubs(x.start, y.start, x.end, y.end, key)
    df.updated <- data.frame(id = 1, polyline = encode_pl(lat = c(x.start, x.end), lon = c(y.start, y.end)))
    google_map_update(map_id = 'map') 
  })
  
  ## Test case
  ## Start location
  #x.start <- 51.534186
  #y.start <- -0.138886
  #
  ## End location
  #x.end <- 51.517647
  #y.end <- -0.119974
  
} 