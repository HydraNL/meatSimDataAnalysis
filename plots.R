# The palette with grey:
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
scale_colour_manual(values=cbPalette)


mHTA <- aggregate(m$meatMean.avg, list(tick = m$tick, HTA = m$HTA),mean)
mOC <- aggregate(m$meatMean.avg, list(tick = m$tick, OC = m$OC),mean)
mHTR <- aggregate(m$meatMean.avg, list(tick = m$tick, HTR = m$HTR),mean)

hHTA <- aggregate(h$habitMean.avg, list(tick = m$tick, HTA = h$HTA),mean)
hOC <- aggregate(h$habitMean.avg, list(tick = m$tick, OC = h$OC),mean)
hHTR <- aggregate(h$habitMean.avg, list(tick = m$tick, HTR = h$HTR),mean)

HTA_HTR <- aggregate(m$meatMean.avg, list(tick = m$tick, HTA = m$HTA, HTR = m$HTR),mean)

hHTA_50 <- hHTA[hHTA$tick<50,]

#plots
HTA_plot <- ggplot(hHTA) + 
            geom_line(aes(x=tick, y=x, group = HTA, colour=HTA)) +
            #facet_wrap(~HTA) +
            guides(col=guide_legend(ncol=3))

HTA_50_plot <- ggplot(hHTA_50, aes(x=tick, y=x, group = HTA, colour=HTA)) + 
  geom_line() +
  #facet_wrap(~HTA) +
  guides(col=guide_legend(ncol=3)) +
  geom_point()

HTR_plot <- ggplot(hHTR) + 
  geom_line(aes(x=tick, y=x, group = HTR, colour=HTR)) +
  #facet_wrap(~HTA) +
  guides(col=guide_legend(ncol=3))

OC_plot <- ggplot(hOC) + 
  geom_line(aes(x=tick, y=x, group = OC, colour=OC)) +
  #facet_wrap(~HTA) +
  guides(col=guide_legend(ncol=3))


HTA_HTR_plot <- ggplot(HTA_HTR) + geom_line(aes(x=tick, y=x, group=HTR, colour=HTR)) +
                           # facet_wrap(~HTA) +
                            guides(col=guide_legend(ncol=1))
HTR_HTA_plot  <- ggplot(HTA_HTR) + geom_line(aes(x=tick, y=x, colour=HTA)) +
  facet_wrap(~HTR) +
  guides(col=guide_legend(ncol=1))

#print(HTA_HTR_plot)