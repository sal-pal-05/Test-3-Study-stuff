## Pre Exam Asignment

library(tidyverse)
library(plyr)
library(dplyr)
library(stringr)
library(ggplot2)

load(file="ost2014_phy_t (1).Robj")

#subset data frame to include only the following fields:
# [1] "cruise"      "transect.id" "haul"        "area"        "tow"         "region"      "dateTime"    "depth"
#[9] "temp"        "salinity"    "pressure"    "sw.density"  "fluoro"      "chl.ug.l"    "irradiance"  "lat"
#17] "lon"

fields <- names(phy_t[,c(1:15,20:21)])
## SUBSETTING: making a df with only the columns we want from the dataset "phy_t"
d <- phy_t[,c(fields)]
d
#sort the data by transect.id and then for each transect so that the first observation is the most westward (data oriented west to east)
d <- arrange(d, transect.id, lon)
d
#for only the undulation ("und") transects, plot the geographic position (i.e. lat and lon) of each transect using ggplot + geom_point
## Label each transect's plot with the name of the transect as the title
## save these plots to a new directory named "und_coords"
dir.create("und_coords")

u <- d[d$tow == "und",]

ddply(.data = u, .variables = c("transect.id"), function(x){
  
  tr <- unique(x$transect.id)
  
  u.plot <- ggplot(data = x, aes(x = lat, y = lon)) +
    geom_point() +
    ggtitle(label = tr)
  
  ggsave(filename = paste0('und_coords/',tr,'.png'),
         plot = u.plot, width = 4, height = 3, units = 'in',
         dpi = 300)
  
}, .inform = T, .progress = "text")

#section 2 ----

#YOu can see from the transect.id values that there were three different studies in the "phy_t" data set: DVM, Eddy, and Spatial.
#For each of these studies, create a histogram of depth values. Use the 'facet' function in ggplot to plot the individual studies.

#identify the separate studies using a custom "if else" function and then loop over the rows of the data frame
#create an "if else" statement to each row to identify the study type using information
#contained in the 'transect.id' field

study.fxn <- function(x){
  
 #t <- stringr::str_split_fixed(string = x[['transect.id']], pattern = "-", n = 3)
  t <- stringr::str_split_fixed(string = x, pattern = "-", n = 3)
  
  s <- t[2]
  
  if(str_detect(string = s, pattern = "L")){
    study <- "lagrangian"
    
    #NOTE: the "fixed' function allows you to match the EXACT character string rather than only part of the string
  } else if(str_detect(string = s, pattern = fixed("Eddy"))){
    study = 'Eddy'
    
  } else if(str_detect(string = s, pattern = "W")) {
    study <- "spatial"
    
  } else if(str_detect(string = s, pattern = "E")) {
    study <- "spatial"
    
  } else if(str_detect(string = s, pattern = "C")) {
    study <- "spatial"
    
  } else if(str_detect(string = s, pattern = "DVM")) {
    study <- "dvm"
    
  } else {
    study = 'Did not work'
  }
  
  return(study)
  
}

d$study = NA

for(i in 1:nrow(d)){
  #get the 'ith" row, from 1 to the end of data frame "d" (i.e., 659008)
  d$study[i] <- study.fxn(x = d$transect.id[i]) #apply the function to the input row of data
  #cat(i, '/', nrow(d), '\n')
}
d$s = NA
d$s <- apply(X = d, 1, FUN = study.fxn)

unique(d$study)
unique(d$s)

d$study_fac<- factor(x = d$s, levels = c("spatial","eddy","dvm","lagrangian"),
                     labels = c("Spatial","Eddy", "DVM","Lagrangian"))

#Make the plot using the field with the different study types
p <- ggplot(data = d, aes(x = depth)) + geom_histogram() + facet_wrap(.~study_fac) #this code answers the question
p #plot the plot.

#fancier plot
p1 <- ggplot(data = d, aes(x = depth)) + geom_histogram(binwidth = 5, color="black", fill="white") + facet_wrap(.~study_fac) #if you wanted to be fancy
p1


#Calculate the average water temperaturefor the shallow, mid-depth, and deep transects in each of the western, central, and eastern regions.

w <- d %>% group_by(region) %>% summarise(avg.tempC = mean(temp, na.rm = T)) #we need to add the argument 'na.rm = T' because there are NAs in the data. Use
# the summary function on data frame 'd' to check for yourself
w
##using a for loop convert temps
w$tempF <- NA
w$tempK <- NA

for(i in 1:nrow(w)){
  
  w[i,]$tempF <- w[i,]$avg.tempC * (9/5) + 32
  w[i,]$tempK <- w[i,]$avg.tempC + 273.15
  
}

library(reshape2)
#Generate grouped barplots using ggplot showing the average temperatures in Farenheit (plot 1) and Kelvin (plot 2). Using facetting to separate the plots by region
#(i.e. west, central, east)


wm <- melt(data = w[w$region != "sof",], id.vars = c("region"),measure.vars = c("tempF","tempK"))

pl <- ggplot(data = wm, aes(x = variable, y=value)) + geom_bar(stat = "identity", position = "dodge") + facet_grid(.~region)
pl

##plotting the same graph without facetting
pl2 <- ggplot(data = wm, aes(fill = region, x = variable, y=value)) + geom_bar(stat = "identity", position = "dodge")
pl2












