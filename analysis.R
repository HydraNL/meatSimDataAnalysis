# Statisticfile
library(ggplot2)

data <- read.csv('C:/Users/rijk/git/meatSimLuna/meatSim/output/DetermineWarmup.2015.mei.26.12_07_44.txt')
params <- read.csv('C:/Users/rijk/git/meatSimLuna/meatSim/output/DetermineWarmup.2015.mei.26.12_07_44.batch_param_map.txt')
dataOrder <- data[with(data, order(run)),]
runlength <- nrow(data)/max(data$run)

breakat <-function(data,runlength){
  newframe <- data[1:runlength,]
  i<- 1
  
  while(i*runlength < nrow(data)){
    from <- (runlength * i) +1
    to <- runlength * (i+1)
    newframe <- data.frame(newframe, data[from:to,])
    i <- i + 1
  }
  newframe
}

data.arr <- breakat(dataOrder,runlength)
meatMean <- data.arr[,c(FALSE,FALSE,FALSE,TRUE,FALSE)]
meatMean.avg <- apply(meatMean,1,mean) #avaraged over runs
meatMean.var <- apply(meatMean,2,var) #variance within runs

habitMean <- data.arr[,c(FALSE,FALSE,FALSE,FALSE,TRUE)]
habitMean.avg <- apply(habitMean,1,mean)

# Basic line graph with points
meatMean.avg.dat <- data.frame(timestep =c(1:length(meatMean.avg)),meatMeanAvg =meatMean.avg)
avg_graph <-
  ggplot(data=meatMean.avg.dat, 
         aes(x=timestep, y=meatMeanAvg, group=1))+
  geom_line(colour="red", linetype="dashed", size=0.5) + 
  geom_point(colour="red", size=1, shape=21, fill="white")


meatMean.frame <- data.frame(timestep = c(1:length(meatMean.avg)),meatMean)
one_run_graph <-
  ggplot(data=meatMean.frame,
         aes(x=timestep, y=MeatMean, group=1))+
    geom_line()


habitMean.avg.dat <- data.frame(timestep =c(1:length(habitMean.avg)),habitMeanAvg = habitMean.avg)
avg_graph <-
  ggplot(data=habitMean.avg.dat, 
         aes(x=timestep, y=habitMeanAvg, group=1))+
  geom_line(colour="red", linetype="dashed", size=0.5) + 
  geom_point(colour="red", size=1, shape=21, fill="white")
         

