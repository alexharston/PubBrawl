# Script to select pubs from shortlist based on crime

suppressMessages(library(dplyr))
suppressMessages(library(tidyr))
suppressMessages(library(httr))
suppressMessages(library(jsonlite))
suppressMessages(library(lubridate))
suppressMessages(library(data.table))

#==============================================================================#
#                                   FUNCTIONS
#==============================================================================#

GetNumberOfCrimes <- function(latitude, longitude, year_month) {
  
  # Create URL
  url <- "https://data.police.uk"
  # path <- 'all-crime?lat=52.629729&lng=-1.131592&date=2017-01'
  path <- paste0("api/crimes-street/all-crime?lat=", latitude, "&lng=", longitude, "&date=", year_month)
  
  # Query API
  raw.result <- GET(url = url, path = path)
  
  # Parse result into data.table
  parsed.dt <- as.data.table(fromJSON(content(raw.result, 
                                              type = "text", 
                                              encoding = "UTF-8"), flatten = TRUE))
  
  # Select certain crimes
  crime.dt <- parsed.dt[category %in% c("anti-social-behaviour", 
                                        "drugs", 
                                        "violent-crime", 
                                        "possession-of-weapons", 
                                        "public-order", 
                                        "theft-from-the-person")]
  
  n_crimes <- nrow(crime.dt)
  
  return(n_crimes)
  
}

# ============

GetNumberOfCrimesPoly <- function(latitude, longitude, year_month, window = 0.001) {
  
  # https://data.police.uk/api/crimes-street/all-crime?poly=52.268,0.543:52.794,0.238:52.130,0.478&date=2017-01
  
  # Get polygon vertices
  nw <- paste0(latitude - window/2, ",", longitude + window/2)
  ne <- paste0(latitude + window/2, ",", longitude + window/2)
  se <- paste0(latitude + window/2, ",", longitude - window/2)
  sw <- paste0(latitude - window/2, ",", longitude - window/2)
  
  # Create URL
  url <- "https://data.police.uk"
  # path <- 'all-crime?lat=52.629729&lng=-1.131592&date=2017-01'
  path <- paste0("api/crimes-street/all-crime?poly=", nw, ":", ne, ":", se, ":", sw, "&date=", year_month)
  
  # Query API
  raw.result <- GET(url = url, path = path)
  
  # Parse result into data.table
  parsed.dt <- as.data.table(fromJSON(content(raw.result, 
                                              type = "text", 
                                              encoding = "UTF-8"), flatten = TRUE))
  
  if(nrow(parsed.dt) == 0) {
    
    n_crimes <- 0
    
  } else {
  
    # Select certain crimes
    crime.dt <- parsed.dt[category %in% c("anti-social-behaviour", 
                                          "drugs", 
                                          "violent-crime", 
                                          "possession-of-weapons", 
                                          "public-order", 
                                          "theft-from-the-person")]
    
    n_crimes <- nrow(crime.dt)
  
  }
  
  return(n_crimes)
  
}

# ============

SelectPubs <- function(pubs.crime.dt, number_pints, safe = c("safe", "unsafe", "carefree")) {
  
  # Get z score and subset depending on safe or not
  
  if(safe == "safe") {
    
    pubs.crime.dt$zscore <- scale(pubs.crime.dt$crime, center = TRUE, scale = TRUE)[1:length(pubs.crime.dt$crime)]
    selected.pubs.dt <- pubs.crime.dt[zscore < 0]
    
  } else if(safe == "unsafe") {
    
    pubs.crime.dt$zscore <- 0 - scale(pubs.crime.dt$crime, center = TRUE, scale = TRUE)[1:length(pubs.crime.dt$crime)]
    selected.pubs.dt <- pubs.crime.dt[zscore < 0]
    
  } else if(safe == "carefree") {
    
    pubs.crime.dt$zscore <- 0 - scale(pubs.crime.dt$crime, center = TRUE, scale = TRUE)[1:length(pubs.crime.dt$crime)]
    selected.pubs.dt <- pubs.crime.dt
    
  }
  
  # Create p distribution
  
  if(safe == "carefree") {
    
    selected.pubs <- sample(x = 1:nrow(selected.pubs.dt),
                            size = number_pints)
    
  } else { 
    
    selected.pubs <- sample(x = 1:nrow(selected.pubs.dt),
                            size = number_pints,
                            prob = abs(1-pnorm(selected.pubs.dt$zscore)))
  }
  
  return(selected.pubs.dt[selected.pubs])
  
}

#==============================================================================#
#                           MAIN
#==============================================================================#

# Set dates
dates <- c(paste0(2016, "-", 10:12), paste0(2017, "-0", 1:9))

# Load pubs
pubs <- fread("~/HackCity18/pubs.tsv")

# Get crime count
pubs$crime <- sapply(1:nrow(pubs), function(x) GetNumberOfCrimesPoly(latitude = pubs$lat[x], longitude = pubs$lng[x], year_month = dates, window = 0.002))
setorder(pubs, crime)

# Get z score and prob
SelectPubs(pubs.crime.dt = pubs,
           number_pints = 5,
           safe = "safe")

SelectPubs(pubs.crime.dt = pubs,
           number_pints = 5,
           safe = "unsafe")

SelectPubs(pubs.crime.dt = pubs,
           number_pints = 5,
           safe = "carefree")
