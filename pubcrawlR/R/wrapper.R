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
    google.route <- PlotRoute(selected.pubs.dt = res, start.coord = start.coord, end.coord = end.coord)

    return(google.route)

}
