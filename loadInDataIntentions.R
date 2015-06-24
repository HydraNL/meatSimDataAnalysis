# Statisticfile
library(ggplot2)
library(reshape2)

setwd('C:/Users/rijk/Dropbox/Studie/2014-2015/Masterscriptie/Data Analysis/')
source('util.R')

#Individual agents needs
# dataI <- read.csv('C:/Users/rijk/git/meatSimLuna/meatSim/output/Relevant/MNI_and_VNI.2015.jun.05.15_43_21.txt')
dataIbetachanged <- read.csv('C:/Users/rijk/git/meatSimLuna/meatSim/MNI_and_VNI.2015.jun.12.16_01_21.txt')
# dataIbetachanged <- read.csv('C:/Users/rijk/git/meatSimLuna/meatSim/output/Relevant/NeedSatisfactionThresholdIndividual.jun.05.16_45_03.txt')
dataIbetatest<- read.csv('C:/Users/rijk/git/meatSimLuna/meatSim/output/relevant/MNI_and_VNI.2015.jun.12.16_24_06_betatest.txt')
dataIbetatestparams <-  read.csv('C:/Users/rijk/git/meatSimLuna/meatSim/output/relevant/MNI_and_VNI.2015.jun.12.16_24_06.batch_param_map.txt')

tick_one <- dataIbetachanged[dataIbetachanged$tick == 1,]
thresholds <- data.frame(ID = tick_one$ID, 
                         ThresE = sapply(tick_one$dataThresholdSelfEnhancement, specify_decimal), 
                         ThresT = sapply(tick_one$dataThresholdSelfTranscendence, specify_decimal), 
                         SatE = sapply(tick_one$dataSatisfactionSelfEnhancement, specify_decimal),
                         SatT = sapply(tick_one$dataSatisfactionSelfTranscendence, specify_decimal))
dataIbetachanged$info <- do.call(paste, c(thresholds, sep="-"))


# dataI.melt <- melt(dataIbetachanged[,c(TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,FALSE,FALSE,FALSE,TRUE)], id=c("ID", "info", "tick"), measured= c("dataNeedSelfEnhancement","dataNeedSelfTranscendence"))
# plotI <- ggplot(subset(dataI.melt, ID == 26 & tick %in% c(0:100))) + 
#         geom_line(aes(x = tick, y = value, group = variable, colour = variable)) +
#         facet_wrap(~info, ncol = 3, shrink = FALSE, scales="free_y") +
#         ggtitle("Need in individual agents differing in threshold (ID -ThrE -ThrT-SatE-SatT)") +
#         theme(plot.title = element_text(lineheight=.8, face="bold"))
# print(plotI)

dataI.melt <- melt(dataIbetachanged[,c(TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,FALSE,FALSE,FALSE,TRUE)], id=c("ID", "info", "tick"), measured= c("dataNeedSelfEnhancement","dataNeedSelfTranscendence"))
plotI <- ggplot(dataI.melt) + 
  geom_line(aes(x = tick, y = value, group = variable, colour = variable)) +
  facet_wrap(~info, ncol = 3, shrink = FALSE, scales="free_y") +
  ggtitle("Need in individual agents differing in threshold (ID -ThrE -ThrT-SatE-SatT)") +
  theme(plot.title = element_text(lineheight=.8, face="bold"))
print(plotI)

# dataI.melt <- melt(dataIbetachanged[,c(TRUE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,TRUE,TRUE,TRUE)], id=c("info", "tick"), measured= c("dataNeedSelfEnhancement","dataNeedSelfTranscendence"))
# plotI <- ggplot(dataI.melt) + 
#   geom_line(aes(x = tick, y = value, group = variable, colour = variable)) +
#   facet_wrap(~info, ncol = 3, shrink = FALSE, scales="free_y") +
#   ggtitle("Satisfaction in individual agents differing in threshold (ID -ThrE -ThrT-SatE-SatT)") +
#   theme(plot.title = element_text(lineheight=.8, face="bold"))
# print(plotI)

# dataI.melt <- melt(dataIbetachanged[,c(TRUE,TRUE,TRUE,TRUE,FALSE,FALSE,FALSE,FALSE,FALSE,TRUE)], id=c("ID", "info", "tick"), measured= c("dataNeedSelfEnhancement","dataNeedSelfTranscendence"))
# dataI.ind <- dataI.melt[dataI.melt$ID == 2,]
# plotInd <- ggplot(dataI.ind) + 
#   geom_line(aes(x = tick, y = value, group = variable, colour = variable))
#   ggtitle("Need of individual agent") +
#   theme(plot.title = element_text(lineheight=.8, face="bold"))
# print(plotInd)

# data.melt <- melt(data[,-1], id=c("random_seed", "tick"), measured= c("MeatNeedMean..MNM.","VegNeedMean..VNM.."))
# data.cast <- acast(data, tick ~ random_seed, value.var ="MeatNeedMean..MNM.")
# data.cast2 <- acast(data, tick ~ random_seed, value.var ="VegNeedMean..VNM..")
# data.cast.var <- apply(data.cast[,-1], 1, var) #variance between runs at different time steps
# data.cast.mean <- apply(data.cast[,-1], 1, mean) #mean of runs at different time steps
# #data.cast.t <- apply(data.cast[,-1], 1, t.test)
# 
# # data.cast.varrun <- apply(data.cast[,-1], 2, var)
#  data.cast.meanrun <-apply(data.cast[,-1], 2, mean)
# data.cast2.meanrun <-apply(data.cast2[,-1], 2, mean)
# data2 <- read.csv('C:/Users/rijk/git/meatSimLuna/meatSim/output/MeatRatio.2015.jun.03.14_17_57.txt')
# params2 <- read.csv('C:/Users/rijk/git/meatSimLuna/meatSim/output/MeatRatio.2015.jun.03.14_17_57.batch_param_map.txt')
# 
# data2.cast <- dcast(data2, tick ~ random_seed)
# data2.cast.var <- apply(data2.cast[,-1], 1, var)
# data2.cast.mean <- apply(data2.cast[,-1], 1, mean)