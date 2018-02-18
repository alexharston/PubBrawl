# Wrapper function to get from Sebastian's list of pubs to a route

# Inputs:
#
# 1. Data.frame of pubs
# 2. Start coords
# 3. End coords
# 4. Number of pubs
# 5. Safety

# Hard coded bits

SelectPubsAndGetRoute <- function(pubs, start.coord, end.coord, number_pints, safe) {

    # Get crime count
    pubs$crime <- sapply(1:nrow(pubs), function(x) GetNumberOfCrimesPoly(latitude = pubs$lat[x], longitude = pubs$lng[x]))

    # Select pub
    selected.pubs <- SelectPubs(pubs.crime.dt = pubs, number_pints = number_pints, safe = safe)

    # Get polyline for Google
    google.route <- PlotRoute(selected.pubs.dt = selected.pubs, start.coord = start.coord, end.coord = end.coord)

    return(list(selectedpubs = selected.pubs,
                polyline = google.route))

}

# Script

# source("~/Github/HackCity18/pubcrawlR/R/getCrime.R")
# source("~/Github/HackCity18/pubcrawlR/R/getRoute.R")
# source("~/Github/HackCity18/pubcrawlR/R/wrapper.R")
#
# pubs <- fread("~/HackCity18pubs.tsv")
#
# start.coord <- c(51.534186, -0.138886)
# end.coord <- c(51.517647, -0.119974)
#
# google.polyline <- SelectPubsAndGetRoute(pubs = pubs,
#                                          start.coord = start.coord,
#                                          end.coord = end.coord,
#                                          number_pints = 5,
#                                          safe = "safe")
