##Generating Heatmaps

library(ggplot2)
library(nutshell)
library(tidyverse)
library(dplyr)

data("batting.2008")
bat=batting.2008 ; rm(batting.2008)

##CREATE A DATAFRAME
##summarize metrics by team:find mean usng players
bat.metrics=bat %>% group_by (teamID) %>% summarize (home.run = mean(HR, na.rm=T),
                                                     runs=mean(R,na.rm=T),
                                                     runs.batted.in=mean(RBI, na.rm=T),
                                                     hits=mean(H,na.rm=T))
##get names of metrics
metric.names=names(bat.metrics)
metric.names

#melt data
library(reshape2)
bat.metrics.melt <- melt(data = bat.metrics, id.vars = c("teamID"),
                         measure.vars = metric.names,
                         variable.name = "metrics")

#pick teams from "bat.metrics.melt" data frame to plot
teams <- c("HOU", "SEA", "WAS", "COL","OAK","ATL")

# PLOT: heatmap
# - here, we use geom_tile()
#---------------------------

ggplot(data = bat.metrics.melt[bat.metrics.melt$teamID %in% teams,],
       aes(x = metrics, y = teamID)) +
  geom_tile(aes(fill = value))




