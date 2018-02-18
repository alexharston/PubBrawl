# Script to select route between pubs from shortlist based on crime

suppressMessages(library(googleway))
suppressMessages(library(data.table))

#==============================================================================#
#                                   FUNCTIONS
#==============================================================================#

PlotRoute <- function(selected.pubs.dt, start.coord, end.coord, api_key = api_key) {

  # Get start and finish coordinates
  start.coord <- start.coord
  end.coord <- end.coord

  # Get pub coordinates as a list of vectors of length 2 all named stop
  selected.pubs.dt[, pub := 1:.N]
  pub.coords <- split(selected.pubs.dt[, .(lat, lng, pub)], by = "pub")
  pub.coords <- lapply(pub.coords, function(x) unlist(x[, pub := NULL]))
  names(pub.coords) <- rep("stop", length(pub.coords))

  google.route <- google_directions(origin = start.coord,
                          destination = end.coord,
                          waypoints = pub.coords,
                          optimise_waypoints=TRUE,
                          key = api_key,
                          mode = "walking")

  return(google.route$routes$overview_polyline)

}

#==============================================================================#
#                           MAIN
#==============================================================================#

# api.key <- "AIzaSyAa55bTPXC1akgwWNm61KT43AsmwI9NZuY"
#
# start.coord <- c(51.534186, -0.138886)
# end.coord <- c(51.517647, -0.119974)
#
# # Start and end coordinates are from user input
# # selected.pubs.dt is the output from SelectPubs
#
# PlotRoute(selected.pubs.dt = res, start.coord = start.coord, end.coord = end.coord)
