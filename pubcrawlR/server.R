server <- function(input, output, session){
 
  # Link text input field (START) to google API autocomplete 
  #observeEvent(input$start, {
  #  print(input$start)
  #  search <- google_place_autocomplete(place_input = input$start)
  #  print(search$predictions$description)
  #  # This will change the value of input$inText, based on x
  #  #updateSelectInput(session, 'start', choices = search$predictions$description)
  #  #updateSelectizeInput(session, 'start', choices = search$predictions$description, server = T)
  #  #updateTextInput(session, 'start',  placeholder = search$predictions$description)
  #  updateTextInput.typeahead(session, 'start', dataset = search$predictions, valueKey = 'description', tokens = 1:5,
  #                            template = HTML("<p class='des'>{{description}}</p>"))
  #  #updateSelect2Input(session, 'start', choices = search$predictions$description, server = T)
  #})
  
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
  })
  
  observeEvent(input$map_map_click, {
    print(input$map_map_click)
  })
  
  
}
