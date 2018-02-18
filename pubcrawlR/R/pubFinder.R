#==============================================================================#
#                             FUNCTIONS
#==============================================================================#
findPubs <- function(x.start, y.start, x.end, y.end, key, quality_threshold = 0, number_pints = 5) {
  # Find midpoint between both locations
  x.mid <- midPoint(c(x.start, y.start), c(x.end, y.end))[1]
  y.mid <- midPoint(c(x.start, y.start), c(x.end, y.end))[2]

  # ==========
  # First get pubs around midpoint
  # ==========

  # Query goolge API to find all pubs within a radius around
  pubs.list <- google_places(search_string = 'pub',
                             location = c(x.mid, y.mid),
                             radius = 500,
                             #rankby = 'distance',
                             #place_type = c('bar', 'restaurant'),
                             key = key)

  # Tidy API search results
  pubs.df <- data_frame(pub_name = pubs.list$results$name) %>%
    bind_cols(., pubs.list$results$geometry$location) %>%
    mutate(rating = pubs.list$results$rating,
           price_level = pubs.list$results$price_level)

  pubs.dt <- as.data.table(pubs.df)

  # ==========
  # Then get pubs at midpoint of start and midpoint
  # ==========
  x.mid.start <- midPoint(c(x.start, y.start), c(x.mid, y.mid))[1]
  y.mid.start <- midPoint(c(x.start, y.start), c(x.mid, y.mid))[2]

  # Query goolge API to find all pubs within a radius around
  pubs.start.list <- google_places(search_string = 'pub',
                             location = c(x.mid.start, y.mid.start),
                             radius = 500,
                             #rankby = 'distance',
                             #place_type = c('bar', 'restaurant'),
                             key = key)

  # Tidy API search results
  pubs.start.df <- data_frame(pub_name = pubs.start.list$results$name) %>%
    bind_cols(., pubs.start.list$results$geometry$location) %>%
    mutate(rating = pubs.start.list$results$rating,
           price_level = pubs.start.list$results$price_level)

  pubs.start.dt <- as.data.table(pubs.start.df)

  # ==========
  # Then get pubs at midpoint of end and midpoint
  # ==========
  x.mid.end <- midPoint(c(x.end, y.end), c(x.mid, y.mid))[1]
  y.mid.end <- midPoint(c(x.end, y.end), c(x.mid, y.mid))[2]

  # Query goolge API to find all pubs within a radius around
  pubs.end.list <- google_places(search_string = 'pub',
                             location = c(x.mid.end, y.mid.end),
                             radius = 500,
                             #rankby = 'distance',
                             #place_type = c('bar', 'restaurant'),
                             key = key)

  # Tidy API search results
  pubs.end.df <- data_frame(pub_name = pubs.end.list$results$name) %>%
    bind_cols(., pubs.end.list$results$geometry$location) %>%
    mutate(rating = pubs.end.list$results$rating,
           price_level = pubs.end.list$results$price_level)

  pubs.end.dt <- as.data.table(pubs.end.df)

  # ==========
  # Merge all three
  # ==========

  pubs.all.dt <- rbind(pubs.dt, pubs.start.dt, pubs.end.dt)

  # ==========
  # Filter based on quality
  # ==========

  quality.pubs.dt <- pubs.all.dt[rating > quality_threshold]

  if(nrow(quality.pubs.dt) < (1.5 * number_pints)) quality.pubs.dt <- pubs.all.dt
  return(quality.pubs.dt)
}

getStations <- function() {
  km.file <- './data/stations.kml'
  stations <- readOGR(km.file)
  return(stations)
}


## Query API
#url <- 'http://whatpub.com/'
#pub.name <- gsub(' ', '+', 'The London Pub')
#path <- sprintf('search?q=%s', pub.name)
#raw.result <- GET(url = file.path(url, path)) # = path)
#raw.result <- rawToChar(raw.result$content)
#raw.result <- htmlParse(raw.result)
#
##read the html page
##get the text from the "option" nodes and then trim the whitespace
#nodes<-trimws(html_text(html_nodes(raw.result, "option")))
#raw.result <- xmlParse(raw.result, asText = T, isHTML = T)
#
