##ddply for plotting


library(plyr)
library(tidyverse)

load(file="fish_data.Rdata")

ggplot(fish,aes(x=parcel.length.m, y=parcel.density.m3)) +
  geom_point() +
  ylab(expression(paste("Parcel Density (",m^3,")"))) +
  facet_wrap(~depth_fac) ## separates by depth and puts each graph for each depth on same plot

##using ddply to plot multiple objects 

ddply(.data=fish, .variables="depth_fac", function(x){
  name=unique(x$depth_fac)
  pl=ggplot(x, aes(x=parcel.length.m, y=parcel.density.m3)) +
    geom_point()+
    xlab("Parcel Length (m)") +
    ylab(expression(paste("Parcel Density (",m^3,")"))) +
    ggtitle(name)
  
  ggsave(filename=paste0(name,".tiff"),
         plot=pl, width=4, height=3, units="in",
         dpi=600, compression="lzw")
}, .progress="text")
  

##plotting 3 variables
##fills in each block with a shade of blue, representing the mpg of the vehicle(darker the blue, the higher mpg)
data("mtcars")
ggplot(mtcars, aes(x= vs, y= cyl, fill=mpg)) +
  geom_tile()

##plotting  a scatter plot with color based on HP of the vehicle
##darker blue point= the higher the HP of that vehicle
ggplot(mtcars, aes(x=wt, y=mpg))+
  geom_point(aes(color = hp))+
  theme_bw()



