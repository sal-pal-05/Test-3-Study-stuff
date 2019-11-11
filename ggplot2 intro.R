library("ggplot2")
load(file="fish_data.Rdata")

#non-ggplot functiond
fish.deep=fish[fish$depth_fac=="Deep",]
plot (x= fish.deep$parcel.start.lon,
      y= fish.deep$parcel.start.lat)
hist(log10(fish$parcel.density.m3))


##ggplot2 functions----
#scatterplot=geom_point
ggplot(data = mpg, aes(x=displ, y=hwy)) +
  geom_point()

#adding color to datapoints
ggplot(data = mpg, aes(x=displ, y=hwy)) +
  geom_point(colour ="blue")

## assigning random colors to datapoints, colors represent the different "classes" of vehicles
ggplot(data = mpg, aes(x=displ, y=hwy, colour=class)) +
  geom_point()
## there are 7 different "classes" therfore 7 different colors
length(unique(mpg$class))

## creating the same plot but this time assigning each data point a specific color based on class
ggplot(data=mpg, aes(x=displ, y=hwy, colour=class)) +
  geom_point() +
  scale_colour_manual(values =c("firebrick2","dodgerblue", "darkgreen","goldenrod","ivory","chocolate2","coral4"))

##making a line graph with "geom_line"

ggplot(data=mpg, aes(x= displ, y= hwy)) +
  geom_line() 

##making a line graph wiht "facets"= this will plot 4 different graps on the same plot, each plot representing a differnet class of vehicle.
ggplot(data=mpg, aes(x= displ, y= hwy)) +
  geom_line() +
  facet_wrap (~class)
  
  ##making a scatter plot with facet wrap
ggplot(data=mpg, aes(x= displ, y= hwy)) +
  geom_point() +
  facet_wrap (~class)
  
##adding more to facet_wrap
##making a scatter plot with facet wrap + assigning it 4 rows (it will be organized, such that 4 rows of graphs will be output)
ggplot(data=mpg, aes(x= displ, y= hwy)) +
  geom_point() +
  facet_wrap (~class, nrow=4)
  
##adding more to facet_wrap
##making a scatter plot with facet wrap + assigning it 41 column (it will be organized, such that all the graphs made, will be organized into a single column.
ggplot(data=mpg, aes(x= displ, y= hwy)) +
  geom_point() +
  facet_wrap (~class, ncol=1)

##adding a smoother ="best fit line"(NOT LINEAR LINE)or trendline
ggplot(data =mpg, aes(x= displ, y= hwy)) +
  geom_point() +
  geom_smooth()

##Adding stuff to smoother/trendline MAKING TRENDLINE LINEAR

ggplot(data =mpg, aes(x= displ, y= hwy)) +
  geom_point() +
  geom_smooth(method = "lm")

##histogram
ggplot(data=mpg, aes(displ, fill=drv)) +
  geom_histogram(binwidth =0.5)
  
##adding lines with color to histogram based on "drv"
ggplot(data=mpg, aes(displ, colour=drv)) +
  geom_freqpoly(binwidth =0.5)





  