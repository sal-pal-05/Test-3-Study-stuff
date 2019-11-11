##plot physical data for each transect

library("plyr")
library("stringr")
library("ggplot2")
library("reshape2")
library("grid")
library("gridExtra")
library("scales")
library("dplyr")
##create directory to store plots
suppressWarnings(dir.create("Plots"))

#load data
load("ost2014_phy_t (1).Robj")

#Call functions:
#Compute the straight line distance (km) from the starting point of a lat,lon trajectory
dist.from.start=function(lat,lon){
  library("oce")
  geodDist(lat1=lat,lon1=lon, lat2=na.omit(lat)[1], lon2=na.omit(lon)[1])/1.852# use if you want to convert from km to nautical miles
}

# Spectral colour map from ColorBrewer
spectral <- function(n=6) {
  library("RColorBrewer")
  rev(brewer.pal(name="Spectral", n=n))
}

scale_fill_spectral <- function(...) {
  scale_fill_gradientn(colours=spectral(...))
}
scale_colour_spectral <- function(...) {
  scale_colour_gradientn(colours=spectral(...))
}

##make plots
#identify variables of interest to plot
vars=c("temp", "salinity", "sw.density","chl.ug.l")

ddply(.data = phy_t, .variables="transect.id", function(x){
  
  x=na.omit(x)
  
  x$depth_round=round(x$depth,digits =1)
  dm=melt(x, id.vars=c("dateTime","depth_round"), measure.vars=vars)
  
  tt <- ggplot(data =dm[dm$variable == "temp",], aes(x=(dateTime), y=-depth_round)) +
    geom_line(aes(colour=value, size = value), na.rm=T, show.legend = F) +
    scale_colour_gradient(high=spectral(), na.value=NA)+
    # scale_x_datetime(name = "Time", labels = date_format("%H:%M"),
    #                  breaks = date_breaks("15 min"), minor_breaks = "5 min") +
    scale_x_datetime(name = "") +
    scale_y_continuous("depth", expand=c(0.01,0.01)) +
    facet_grid(variable~.) +
    theme(panel.background = element_rect(fill = "white"),
          panel.grid.major = element_line(colour = "black"),
          strip.text.y = element_text(face = "bold", size = 12)) +
    theme(axis.text.x = element_blank(),
          axis.title.y = element_text(face = "bold", size = 12)) +
    ggtitle(label = unique(x$transect.id))
  
})












