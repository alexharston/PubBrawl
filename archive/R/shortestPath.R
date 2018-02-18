
# Start location
x.start <- 51.534186
y.start <- -0.138886

# End location
x.end <- 51.517647
y.end <- -0.119974

library(TSP)
library("TSP")
data("USCA312")
USCA312

# =======
library(TSP)


res[, pub := letters[1:nrow(res)]]

start_end <- data.table(pub = c("start", "end"), lat = c(51.534186, 51.517647), lng = c(-0.138886, -0.119974))
# start_end <- data.table(pub = c("start", "end"), lat = c(51.534186 - 100, 51.517647 + 100), lng = c(-0.138886 - 100, -0.119974 + 100))
coords.dt <- rbind(res[, .(pub, lat, lng)], start_end)

plot(coords.dt[, .(lat, lng)])
text(coords.dt[, .(lat, lng)], cex = 2)

dist.mat <- as.matrix(dist(coords.dt[, .(lat, lng)], method = "euclidean", diag = TRUE))



diag(dist.mat) <- 1
dist.mat[ 7, ] = .99
dist.mat[ , 7] = .99

order_pub <- integer(length = nrow(coords.dt))

order_pub[1] <- 6

for(i in 2:length(order_pub)) {
  
  order_pub[i] <- which.min(dist.mat[order_pub[i - 1], ])
  print(order_pub[i])
  
  dist.mat[order_pub[i - 1], ] = 1
  dist.mat[, order_pub[i - 1]] = 1
  
  # dist.mat[ order_pub[i-1], order_pub[i]] = 1
  # dist.mat[ order_pub[i], order_pub[i - 1]] = 1
  print(dist.mat)
  
}

which.min(dist.mat[6, ])
which.min(dist.mat[4, ])
which.min(dist.mat[2, ])




library
which.min(dist.mat[5, ])

order_pub
which.min(dist.mat[, ])



# Anything from start



tsp.dist <- TSP(dist.mat)

path <- solve_TSP(tsp.dist, method = "random")
labels(path)

while(path[1] != (nrow(coords.dt) - 1) | path[nrow(coords.dt)] != nrow(coords.dt)) {
  
  path <- solve_TSP(tsp.dist)
  
}


while(path[1] != (nrow(coords.dt) - 1)) {
  
  path <- solve_TSP(tsp.dist, method = "farthest_insertion")
  
}

labels(path)







