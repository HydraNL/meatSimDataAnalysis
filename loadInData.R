# Statisticfile
library(ggplot2)

setwd('C:/Users/rijk/Dropbox/Studie/2014-2015/Masterscriptie/Data Analysis/')
source('util.R')

data <- read.csv('C:/Users/rijk/git/meatSimLuna/meatSim/output/DetermineWarmup.2015.jun.02.12_48_37.txt')
params <- read.csv('C:/Users/rijk/git/meatSimLuna/meatSim/output/DetermineWarmup.2015.jun.02.12_48_37.batch_param_map.txt')

paramsSelect<- data.frame(run = params$run, randomSeed = params$randomSeed, params$HABIT_THRESHOLD_ABSOLUTE, params$HABIT_THRESHOLD_RELATIVE, params$OUTSIDE_CONTEXT)

total <- merge(data, paramsSelect, by="run")
totalOrder <- total[with(total, order(randomSeed,run)),]

runlength <- nrow(data)/max(data$run)
seedLength <- nrow(data)/max(data$random_seed)

broken <- breakAt(totalOrder,seedLength)

data.only <- broken[,c(rep(FALSE,3),rep(TRUE,2),rep(FALSE,4))]
data.params <- data.frame(tick = broken$tick,
                          HTA = broken$params.HABIT_THRESHOLD_ABSOLUTE,
                          HTR = broken$params.HABIT_THRESHOLD_RELATIVE,
                          OC = broken$params.OUTSIDE_CONTEXT)

data.rdy <- data.frame(data.params, data.only)

meatMean <- data.only[,c(TRUE,FALSE)]
meatMean.avg <- apply(meatMean,1,mean) #avaraged over runs

habitMean <- data.only[,c(FALSE,TRUE)]
habitMean.avg <- apply(habitMean,1,mean)

meatMean.avg.params <- data.frame(data.params, meatMean.avg)
habitMean.avg.params <- data.frame(data.params, habitMean.avg)
m<- meatMean.avg.params
h<- habitMean.avg.params

