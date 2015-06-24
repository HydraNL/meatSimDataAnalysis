
library(rpart)

# #Tree's for habitMean.avg
# tree <- rpart(habitMean.avg~HTA+HTR+OC+tick,  data = h, method="anova")
# treep <- prune(tree, cp=   tree$cptable[which.min(tree$cptable[,"xerror"]),"CP"])
# 
# summary(treep)
# plot(treep, uniform=TRUE, 
#      main="Regression Tree for percentage acting out of Habit")
# text(treep, use.n=TRUE, all=TRUE, cex=.8)

#Remove warmimg up and aggregate over ticks
noticks <- h[h$tick>50,]
noticks <- aggregate(noticks$habitMean.avg, 
                    list(HTA = noticks$HTA, HTR = noticks$HTR, OC = noticks$OC),
                    mean)
#Tree without ticks
tree2 <-  rpart(x~HTA+HTR+OC,  data = noticks, method="anova")
tree2p <- prune(tree2, cp=   tree2$cptable[which.min(tree2$cptable[,"xerror"]),"CP"])

summary(tree2p)
plot(tree2p, uniform=TRUE, 
      main="Regression Tree for percentage acting out of Habit, ticks avaraged")
text(tree2p, use.n=TRUE, all=TRUE, cex=.8)



# #Tree to see the clustering of data for three clusters
# tree3 <- rpart(data~HTA+HTR+OC, data = threeclust.avg.params, method="anova")
# tree3p <- prune(tree3, cp=   tree3$cptable[which.min(tree3$cptable[,"xerror"]),"CP"])
# 
# #Tree for difference between two and three clusters
# tree4 <- rpart(data~HTA+HTR+OC, data = difference.avg.params, method="anova")
# tree4p <- prune(tree4, cp=   tree4$cptable[which.min(tree4$cptable[,"xerror"]),"CP"])
# 
# #fancy = TRUE adds rounds, rpart.plot for superplots
# plot(tree3, uniform=TRUE, 
#      main="Classification Tree for 3Cluster")
# text(tree3, use.n=TRUE, all=TRUE, cex=.8, fancy = TRUE)
# 
# plot(tree4p, uniform=TRUE, 
#      main="Classification Tree for difference in fit for 2Clusters and 3Clusters")
# text(tree4p, use.n=TRUE, all=TRUE, cex=.8)

#post(tree3, file="c:/tree.ps",
#     title = "Classification Tree for Kyphosis")