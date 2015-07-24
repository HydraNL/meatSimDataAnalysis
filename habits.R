# Statisticfile
library(ggplot2)
library(reshape2)
library(plyr) #to use the subset function
library(rpart) #for tree

setwd('C:/Users/rijk/Dropbox/Studie/2014-2015/Masterscriptie/Data Analysis/')
source('util.R')

data <- read.csv('C:/Users/rijk/git/meatSimLuna/meatSim/output/NewRelevant/MR_and_HR.2015.jul.24.18_04_13.txt')
params <- read.csv('C:/Users/rijk/git/meatSimLuna/meatSim/output/NewRelevant/MR_and_HR.2015.jul.24.18_04_13.batch_param_map.txt')

data <- data.frame(data) #pick things out the data
params<- data.frame(run = params$run,HTA = params$HABIT_THRESHOLD_ABSOLUTE, HTR =params$HABIT_THRESHOLD_RELATIVE, OC =params$OUTSIDE_CONTEXT)

data <- merge(data, params, by="run")#throw away unncessary columns
#data<- data[with(data, order(randomSeed,run)),]
data <- subset(data, tick==500)
data <- data[,c(-1,-5)]

# #Won't erase things not mentioned, so be sure to delete them.
 data.melt <- melt(data, id=c("random_seed","HTA", "HTR", "OC"), 
                                    measured= c("MeatMean","HabitualMean"))

# left are ids, right is the variable to split on
# the rest is aggregated on (except when there is actually one instance per row?)
# subset can be used to pick variable
data.melt<- subset(data.melt, variable=="HabitualMean")
data.cast <- dcast(data.melt, OC+HTR+HTA~variable, mean)

tree2 <-  rpart(HabitualMean~HTA+HTR+OC,  data = data.cast, method="anova")
tree2p <- prune(tree2, cp=   tree2$cptable[which.min(tree2$cptable[,"xerror"]),"CP"])
 
 summary(tree2p)
 plot(tree2p, uniform=TRUE, 
      main="Regression Tree for percentage acting out of Habit")
 text(tree2p, use.n=TRUE, all=TRUE, cex=.8)


# 
# 
# 
# 
 



# 

# 
# summary(tree2p)
# plot(tree2p, uniform=TRUE, 
#      main="Regression Tree for percentage acting out of Habit, ticks avaraged")
# text(tree2p, use.n=TRUE, all=TRUE, cex=.8)


# mHTA <- aggregate(m$meatMean.avg, list(tick = m$tick, HTA = m$HTA),mean)
# plotI <- ggplot(data.melt) + 
#   geom_line(aes(x = tick, y = value, group = variable, colour = variable)) +
#   #facet_wrap(~HTA, ncol = 3, shrink = FALSE, scales="free_y") +
#   #ggtitle("Need in individual agents differing in threshold (ID -ThrE -ThrT-SatE-SatT)") +
#   theme(plot.title = element_text(lineheight=.8, face="bold"))
# print(plotI)

# runlength <- nrow(data)/max(data$run)
# seedLength <- nrow(data)/max(data$random_seed)
# 
# broken <- breakAt(totalOrder,seedLength)
# 
# data.only <- broken[,c(rep(FALSE,3),rep(TRUE,2),rep(FALSE,4))]
# data.params <- data.frame(tick = broken$tick,
#                           HTA = broken$params.HABIT_THRESHOLD_ABSOLUTE,
#                           HTR = broken$params.HABIT_THRESHOLD_RELATIVE,
#                           OC = broken$params.OUTSIDE_CONTEXT)
# 
# data.rdy <- data.frame(data.params, data.only)
# 
# meatMean <- data.only[,c(TRUE,FALSE)]
# meatMean.avg <- apply(meatMean,1,mean) #avaraged over runs
# 
# habitMean <- data.only[,c(FALSE,TRUE)]
# habitMean.avg <- apply(habitMean,1,mean)
# 
# meatMean.avg.params <- data.frame(data.params, meatMean.avg)
# habitMean.avg.params <- data.frame(data.params, habitMean.avg)
# m<- meatMean.avg.params
# h<- habitMean.avg.params

