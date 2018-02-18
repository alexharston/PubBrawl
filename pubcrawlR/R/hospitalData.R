#==============================================================================#
#                             FUNCTIONS
#==============================================================================#
integrateWithWait <- function(URL,ae_trust,loc_ratings){
  x <- getURL(URL)
  out <- read.csv(textConnection(x),skip=6,header=FALSE, stringsAsFactors = FALSE)
  df <- out %>% select(V3,V4,V6,V7,V9)
  df$total_attendance <- df$V4+df$V6
  df$total_over_4hrs <- df$V7+df$V9
  df$total_under_4hrs <- df$total_attendance - df$total_over_4hrs
  df$percent_under_4hrs <- (df$total_under_4hrs/df$total_attendance)*100
  final <- df %>% select(V3,percent_under_4hrs)
  wait_times <- inner_join(final,ae_trust,by=c("V3"="V2"))
  final_frame <- inner_join(wait_times,loc_ratings,by=c("V1"="hospital"))
  names(final_frame) <- c("trust","percent_under_4hrs","centre","lat","long","google_review")
  final_frame[is.na(final_frame)] <- "Not available"
  return(final_frame)
}

getHospRatings <- function(x.start,y.start,x.end,y.end,key){
  x.mid <- midPoint(c(x.start, y.start), c(x.end, y.end))[1]
  y.mid <- midPoint(c(x.start, y.start), c(x.end, y.end))[2]
  
  # Query google API to find all pubs within a radius around
  pubs.list <- google_places(search_string = 'accident and emergency',
                             location = c(x.mid, y.mid),
                             radius = 10000,
                             #rankby = 'distance',
                             #place_type = c('bar', 'restaurant'),
                             key = key)
  accidentandemergency <- data.frame(unique(pubs.list$results$name),pubs.list$results$geometry$location, pubs.list$results$rating)
  uc.list <- google_places(search_string = 'urgent care centre',
                           location = c(x.mid, y.mid),
                           radius = 10000,
                           #rankby = 'distance',
                           #place_type = c('bar', 'restaurant'),
                           key = key)
  urgent_Care <- data.frame(unique(uc.list$results$name),uc.list$results$geometry$location, uc.list$results$rating)
  names(urgent_Care) <- c("hospital","lat","long","google_review")
  names(accidentandemergency) <- c("hospital","lat","long","google_review")
  loc_ratings <- rbind(urgent_Care,accidentandemergency)
  return(loc_ratings)
}


getMinHos <- function(pubs,final_frame,key){
    hospital_co <- final_frame %>% dplyr::select(lat,long)
    hospital.dt <- data.table(hospital_co)[, hosp := seq(1:nrow(hospital_co))]
    test2 <- split(hospital.dt, by = "hosp")
    hos2 <- lapply(test2, function(x) unlist(x[, hosp := NULL]))
    df <- google_distance(origins = c(pubs[1]$lat,pubs[1]$lng),
                          destinations = hos2,
                          mode="driving",
                          key = key)
    ind <- which.min(df$rows$elements[[1]]$distance[,2])
    return(data.frame(t(data.frame(hos2[ind]))))
}

getFinalString <- function(hos_coords,final_frame){
  final_frame$lat <- as.character(final_frame$lat)
  final_frame$long <- as.character(final_frame$long)
  final <- final_frame %>% filter(lat==as.character(hos_coords[[1]]) & long==as.character(hos_coords[[2]]))
  return(paste0("The nearest A&E to your Pub Brawl (TM) is <b>",final$centre,"</b>. It has an average google review of <b>",final$google_review,"</b> and <b>",round(final$percent_under_4hrs,2),"%</b> of people get seen within 4 hours, so you probably won't die."))
}

##### MAIN ##########
#getNearestAandE <- function(x.start,
#                            y.start,
#                            x.end, 
#                            y.end,
#                            key,
#                            pubs){
#  loc_ratings <- getHospRatings(x.start,y.start,x.end,y.end,key)
#  ae_trust <- fread("london_AandE_plusTrust.csv",header=FALSE)
#  URL_jan18 <- "https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/02/January-csv-att-e652S.csv"
#  final_frame <- integrateWithWait(URL_jan18,ae_trust,loc_ratings)
#  hos_coords <- getMinHos(pubs,final_frame,key)
#  return(getFinalString(hos_coords,final_frame))
#}