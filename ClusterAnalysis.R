#Note to self, use apply in terms of the dimensions you wish to preserve.
threeclust <- apply(tryOut, c(1,2), kmeans3)
threeclust.avg <- apply(threeclust, 1, mean)

twoclust <- apply(tryOut, c(1,2), kmeans2)
difference <- threeclust - twoclust
difference.avg <- apply(difference, 1, mean)

paramsHHO <- data.frame(HTA =totalOrder$HTA, HTR =totalOrder$HTR, OC =totalOrder$OC)
paramsHHO.order <- unique(paramsHHO[with(paramsHHO, order(HTA,HTR,OC)),]) #throws out doubles and orders them

#NB: we are kind of guessing that parameters and data will lign up correctly, NOT AYMORE
#note that you can extract the names from variables with names(threeclust.avg)
#they seem to be correct
threeclust.avg.params <- data.frame(paramsHHO.order,data=threeclust.avg)
difference.avg.params <- data.frame(paramsHHO.order,data=difference.avg)
#The bigger the value the more scattered the data is, as it can't even have a small variance with 3 clusters


threeCluster_plot <- ggplot(threeclust.avg.params) + 
  geom_point(aes(x=HTR, y=data, group = OC, colour=OC)) +
  facet_wrap(~HTA) +
  guides(col=guide_legend(ncol=3))
print(threeCluster_plot)

difference_plot <- ggplot(difference.avg.params) + 
  geom_point(aes(x=HTR, y=data, group = OC, colour=OC)) +
  facet_wrap(~HTA) +
  guides(col=guide_legend(ncol=3))
print(difference_plot)


kmeans3 <- function(data){
  ifelse(var(data) == 0,
         0,
         sum(kmeans(data, centers=3)$withinss)
  )
}

kmeans2 <- function(data){
  ifelse(var(data) == 0,
         0,
         sum(kmeans(data, centers=2)$withinss)
  )
}

# Determine number of clusters
clusterPlot <- function(mydata){
  wss <- (1:15)
  for (i in 2:15) wss[i] <- sum(kmeans(mydata, 
                                       centers=i)$withinss)
  plot(1:15, wss, type="b", xlab="Number of Clusters",
       ylab="Within groups sum of squares")
  
}
