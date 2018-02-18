server <- function(input, output, session) {

  # DEFAULT: pub crawl between Camden town and Holborn station
  y.start <- stations@coords[grep(stations$Name, pattern = 'Camden'), 1]
  x.start <- stations@coords[grep(stations$Name, pattern = 'Camden'), 2]
  y.end <- stations@coords[grep(stations$Name, pattern = 'Holborn'), 1]
  x.end <- stations@coords[grep(stations$Name, pattern = 'Holborn'), 2]
  start.coord <- c(x.start, y.start)
  end.coord <- c(x.end, y.end)

  # Get list of pubs between two stations
  pubs <- findPubs(x.start, y.start, x.end, y.end, key)

  # Get list of a) selected pubs and b) polyline for GoogleMaps
  google.polyline <- SelectPubsAndGetRoute(pubs = pubs,
      start.coord = start.coord,
      end.coord = end.coord,
      number_pints = 5, 
      safe = 'safe',
      api_key = key)
  
  # Get nearest hosptial
  output$hospital_str <- renderText({
    getNearestAandE(x.start, y.start, x.end, y.end,
                    key, google.polyline$selectedpubs)
  })
  
  # Insert nearest hospital as UI 
  #insertUI(selector = 'map', where = 'afterEnd', ui = hospital.string)

  # PLOT a map with pubs as points and shortest path as blue line
  output$map <- renderGoogle_map({
    google_map(key = key, data = google.polyline$selectedpubs, search_box = F) %>%
      add_markers(lat = 'lat', lon = 'lng', info_window = 'label') %>%
      add_polylines(data = df, polyline = google.polyline$polyline$points, stroke_weight = 9) 
  })
 
  # Define GO buttom functionallity 
  observeEvent(input$go, {
    # Get station coordinates
    y.start <- stations@coords[stations$Name == input$start, 1]
    x.start <- stations@coords[stations$Name == input$start, 2]
    y.end <- stations@coords[stations$Name == input$end, 1]
    x.end <- stations@coords[stations$Name == input$end, 2]
    # Combine station coordinates
    start.coord <- c(x.start, y.start)
    end.coord <- c(x.end, y.end)
    # Find pubs for coordinates
    pubs <- findPubs(x.start, y.start, x.end, y.end, key, 
                     quality_threshold = input$google_review,
                     number_pints = input$number_pints)
    # Define saftey status
    safety <- safety.choices$id[safety.choices$type == input$safety]
    # Get list of a) selected pubs and b) polyline for GoogleMaps
    google.polyline <- SelectPubsAndGetRoute(pubs = pubs,
        start.coord = start.coord,
        end.coord = end.coord,
        number_pints = input$number_pints,
        safe = safety,
        api_key = key)
    print(google.polyline$selectedpubs)
    google_map_update(map_id = 'map') %>%
      clear_markers() %>%
      add_markers(data = google.polyline$selectedpubs, lat = 'lat', lon = 'lng', info_window = 'label') %>%
      clear_polylines() %>%
      add_polylines(data = df, polyline = google.polyline$polyline$points, stroke_weight = 9)    
  })
}