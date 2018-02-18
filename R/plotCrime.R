suppressMessages(library(ggplot2))
suppressMessages(library(RColorBrewer))
suppressMessages(library(dplyr))
suppressMessages(library(tidyr))
suppressMessages(library(httr))
suppressMessages(library(jsonlite))
suppressMessages(library(lubridate))
suppressMessages(library(data.table))

PlotCrimes <- function(latitude, longitude, year_month = c(paste0(2016, "-", 10:12), paste0(2017, "-0", 1:9)), window = 0.002) {

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

  # If no crime
  if(nrow(parsed.dt) == 0) {

    p <- ggplot()

  # Plot pie chart of crime
  } else {

    # Select certain crimes
    crime.dt <- parsed.dt[category %in% c("anti-social-behaviour",
                                          "drugs",
                                          "violent-crime",
                                          "possession-of-weapons",
                                          "public-order",
                                          "theft-from-the-person")]

    p <- ggplot(crime.dt, aes(x = factor(1), fill = category)) +
      geom_bar(width = 1) +
      coord_polar(theta = "y") +
      labs(title = "",
           x = "",
           y = "",
           fill = "") +
      theme_classic() +
      theme(axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            panel.border = element_blank(),
            panel.grid = element_blank(),
            axis.ticks = element_blank(),
            axis.text.x = element_blank(),
            axis.text.y = element_blank(),
            axis.line = element_blank()) +
      scale_fill_brewer(palette = "Set1")

    p

  }

  print(p)

}
