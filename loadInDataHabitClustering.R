# Statisticfile
library(ggplot2)
library(reshape2)

setwd('C:/Users/rijk/Dropbox/Studie/2014-2015/Masterscriptie/Data Analysis/')
source('util.R')

  data <- read.csv('C:/Users/rijk/git/meatSimLuna/meatSim/output/Relevant/HabitMeat.2015.mei.28.14_30_51.txt')
params <- read.csv('C:/Users/rijk/git/meatSimLuna/meatSim/output/Relevant/HabitMeat.2015.mei.28.14_30_51.batch_param_map.txt')

paramsSelect<- data.frame(run = params$run, randomSeed = params$randomSeed, params$HABIT_THRESHOLD_ABSOLUTE, params$HABIT_THRESHOLD_RELATIVE, params$OUTSIDE_CONTEXT)

total <- merge(data, paramsSelect, by="run")
total$ID <- total$ID%%30
totalOrder <- total[with(total, order(randomSeed,run,ID)),]

runlength <- nrow(data)/max(data$run)
seedLength <- nrow(data)/max(data$random_seed)

totalOrder <- data.frame(randomSeed = totalOrder$randomSeed,
                                                  ID = totalOrder$ID,
                                                  HTA = totalOrder$params.HABIT_THRESHOLD_ABSOLUTE,
                                                  HTR = totalOrder$params.HABIT_THRESHOLD_RELATIVE,
                                                 OC = totalOrder$params.OUTSIDE_CONTEXT,
                                                value =  totalOrder$dataHabitStrengthMeat)
#As far as I see cast is slower than acast or dcast but rpeserves more info
tryOut <- cast(totalOrder, ... ~ randomSeed ~ ID)
#Should be able to use iapply but shit doesn't work. Iterator does work, but is wrong one.


#breaks on every independent run
#broken <- breakAt(totalOrder,runlength)



#data.only <- broken[,c(rep(FALSE,4),rep(TRUE,1),rep(FALSE,4))] #takes only MeatHabitStrength
#data.params <- data.frame(randomSeed = broken$randomSeed,
#                          ID = broken$ID,
#                          HTA = broken$params.HABIT_THRESHOLD_ABSOLUTE,
#                          HTR = broken$params.HABIT_THRESHOLD_RELATIVE,
#                          OC = broken$params.OUTSIDE_CONTEXT)

#data.rdy <- data.frame(data.params, data.only)

#breaks after one batch of ID's (why different? because ordered on ID)
#data.IDs <- breakAt(data.rdy, 30)

