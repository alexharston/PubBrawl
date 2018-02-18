server <- function(input, output, session) {

  library(data.table)
  source("R/getCrime.R")
  source("R/getRoute.R")
  source("R/wrapper.R")
  source("R/pubFinder.R")

  y.start <- stations@coords[grep(stations$Name, pattern = 'Camden'), 1]
  x.start <- stations@coords[grep(stations$Name, pattern = 'Camden'), 2]
  y.end <- stations@coords[grep(stations$Name, pattern = 'Holborn'), 1]
  x.end <- stations@coords[grep(stations$Name, pattern = 'Holborn'), 2]

  #df <- data.frame(id = 1, polyline = encode_pl(lat = c(x.start, x.end), lon = c(y.start, y.end)))
  pubs <- findPubs(x.start, y.start, x.end, y.end, key)

  # Define API key
  # key <- 'AIzaSyBBm8BH5k410AQ9lr6Rm1HrYyyI8X-gULI'

  # Test case
  # Start location
  # x.start <- 51.534186
  # y.start <- -0.138886

  # # End location
  # x.end <- 51.517647
  # y.end <- -0.119974

  start.coord <- c(x.start, y.start)
  end.coord <- c(x.end, y.end)

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

  # Get list of pubs
  # df <- data.frame(id = 1, polyline = encode_pl(lat = c(x.start, x.end), lon = c(y.start, y.end)))
  #pubs <- findPubs(x.start, y.start, x.end, y.end, key)
  
  pubs <- findPubs(x.start, y.start, x.end, y.end, key)
     # quality_threshold = sliderValues$Value[sliderValues$Name == "GoogleReview"],
     # number_pints = sliderValues$Value[sliderValues$Name == "NumberPints"])

  # Get list of a) selected pubs and b) polyline for GoogleMaps
  google.polyline <- SelectPubsAndGetRoute(pubs = pubs,
      start.coord = start.coord,
      end.coord = end.coord,
      number_pints = 5, #sliderValues$Value[sliderValues$Name == "NumberPints"],
      safe = 'safe',
      api_key = key)

  # print(google.polyline$polyline)

  # library(sf)

  output$map <- renderGoogle_map({
    google_map(key = key, data = google.polyline$selectedpubs, search_box = F) %>%
      add_markers(lat = 'lat', lon = 'lng', info_window = 'pub_name') %>%
      add_polylines(data = df, polyline = google.polyline$polyline$points, stroke_weight = 9)    #  add_drawing(drawing_modes = c('rectangle')) 
  })
 
    
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
    pubs <- findPubs(x.start, y.start, x.end, y.end, key)
    # Get list of a) selected pubs and b) polyline for GoogleMaps
    google.polyline <- SelectPubsAndGetRoute(pubs = pubs,
        start.coord = start.coord,
        end.coord = end.coord,
        number_pints = input$number_pints,
        safe = "safe",
        api_key = key)
    print(pubs)
    google_map_update(map_id = 'map') %>%
      clear_markers() %>%
      add_markers(data = google.polyline$selectedpubs, lat = 'lat', lon = 'lng', info_window = 'pub_name') %>%
      clear_polylines() %>%
      add_polylines(data = df, polyline = google.polyline$polyline$points, stroke_weight = 9)    
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
