library(reshape2)
library(ggplot2)

h_zero <- h[h$habitMean.avg < 0.3,]
h_zero_491 <- h_zero[h_zero$tick == 491,]

#Aggregating over ticks fuck it up because it is 0 everywhere starting
#aggregate over ticks
h_zero_WRONG <- aggregate(h_zero$habitMean.avg, 
                    list(HTA = h_zero$HTA, HTR = h_zero$HTR, OC = h_zero$OC),
                    mean)

sp <- ggplot(h_zero_491, aes(x=HTA, y=HTR)) +
  geom_point(shape=1) 

sp2 <- ggplot(h_zero_491, aes(x=HTA, y=HTR)) +
    geom_point(shape=1) + 
    facet_grid(OC ~ .)

print(sp2)
#selecting out of matrix
interesting <- h[which(h$HTR==0.9 & h$OC ==0.5 & h$HTA == 2), ]