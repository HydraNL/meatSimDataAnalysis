library(ggplot2)
library(reshape2)

setwd('C:/Users/rijk/Dropbox/Studie/2014-2015/Masterscriptie/Data Analysis/')
source('util.R')

data <- read.csv('C:/Users/rijk/git/meatSimLuna/meatSim/output/relevant/MNI_and_VNI.2015.jun.16.11_59_46_updatedIntentionfunction.txt')
params <-  read.csv('C:/Users/rijk/git/meatSimLuna/meatSim/output/relevant/MNI_and_VNI.2015.jun.16.11_59_46.batch_param_map.txt')

params <- data.frame(run = params$run, beta = params$selfEbeta)
data <- merge(data, params, by="run")

data <- subset(data, beta ==0.03)
tick_one <- data[data$tick == 1,]
thresholds <- data.frame(ID = tick_one$ID, 
                         ThresE = sapply(tick_one$dataThresholdSelfEnhancement, specify_decimal), 
                         ThresT = sapply(tick_one$dataThresholdSelfTranscendence, specify_decimal), 
                         SatE = sapply(tick_one$dataSatisfactionSelfEnhancement, specify_decimal),
                         SatT = sapply(tick_one$dataSatisfactionSelfTranscendence, specify_decimal))
data$info <- do.call(paste, c(thresholds, sep="-"))
data <- data[,-c(1,6,7,8)] #remove run, seed, next time just look at runnr

dataNeed <- data[,-c(5,6)]
data.melt <- melt(dataNeed, id=c("ID", "info", "tick", "beta"), measured= c("dataNeedSelfEnhancement","dataNeedSelfTranscendence"))
plotI <- ggplot(data.melt) + 
  geom_line(aes(x = tick, y = value, group = variable, colour = variable)) +
  facet_wrap(~info, ncol = 3, shrink = FALSE, scales="free_y") +
  ggtitle("Need in individual agents differing in threshold (ID -ThrE -ThrT-SatE-SatT)") +
  theme(plot.title = element_text(lineheight=.8, face="bold"))
print(plotI)