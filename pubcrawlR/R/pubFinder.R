#==============================================================================#
#                             FUNCTIONS
#==============================================================================#
findPubs <- function(x.start, y.start, x.end, y.end, key) {
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
  return(pubs.df)

}

# Query API
#Url <- 'http://whatpub.com/'
#Pub.name <- paste('The London Pub', collapse = '+')
#Path <- 'search?q=pub.name'
#Path <- 'api/1/GetPubDetails'
#Raw.result <- GET(url = url, path = path)
#Raw.result$status_code
#RawToChar(raw.result$content)
