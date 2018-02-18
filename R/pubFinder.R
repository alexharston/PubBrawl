suppressMessages(library(googleway))
suppressMessages(library(geosphere))
suppressMessages(library(dplyr))
suppressMessages(library(tidyr))
suppressMessages(library(getopt))
suppressMessages(library(jsonlite))

#==============================================================================#
#                             FUNCTIONS
#==============================================================================#
findPubs <- function(x.start, y.start, x.end, y.end, api.key, quality_threshold) {
  # Find mindpoint between both locations
  x.mid <- midPoint(c(x.start, y.start), c(x.end, y.end))[1]
  y.mid <- midPoint(c(x.start, y.start), c(x.end, y.end))[2]

  # Query goolge API to find all pubs within a radius around
  pubs.list <- google_places(search_string = 'pub',
                             location = c(x.mid, y.mid),
                             radius = 20000,
                             #rankby = 'distance',
                             #place_type = c('bar', 'restaurant'),
                             key = api.key)

  # Tidy API search results
  pubs.df <- data_frame(pub_name = pubs.list$results$name) %>%
    bind_cols(., pubs.list$results$geometry$location) %>%
    mutate(rating = pubs.list$results$rating,
           price_level = pubs.list$results$price_level)

  pubs.dt <- as.data.table(pubs.df)

  quality.pubs.dt <- pubs.dt[rating > quality_threshold]

  if(nrow(quality.pubs.dt) == 0) quality.pubs.dt <- pubs.dt

}



#==============================================================================#
#                           MAIN
#==============================================================================#
## Define API key
#key <- ' AIzaSyBaNsBP0XxPQ3Y0V-WMf7fzj9ZSac2nzak '
#
## Test case
## Start location
#x.start <- 51.534186
#y.start <- -0.138886
#
## End location
#x.end <- 51.517647
#y.end <- -0.119974


#write_json(pubs.df, '/Users/steinhs/privat_projects/HackCity18/pubs.json')
