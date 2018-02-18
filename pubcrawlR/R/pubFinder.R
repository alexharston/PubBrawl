#==============================================================================#
#                             FUNCTIONS
#==============================================================================#
findPubs <- function(x.start, y.start, x.end, y.end, key, quality_threshold = 0, number_pints = 5) {
  # Find midpoint between both locations
  x.mid <- midPoint(c(x.start, y.start), c(x.end, y.end))[1]
  y.mid <- midPoint(c(x.start, y.start), c(x.end, y.end))[2]

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

    quality.pubs.dt <- pubs.dt[rating > quality_threshold]

    if(nrow(quality.pubs.dt) < (1.5 * number_pints)) quality.pubs.dt <- pubs.dt

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
