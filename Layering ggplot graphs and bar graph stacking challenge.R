library(ggplot2)
##one geom
data(economics)
e=economics
rm(economics)

##plotting unemployment rates vs date
unemploy=ggplot(data=e, aes(x=date, y= unemploy))+
  geom_line()
unemploy


##multiple geoms
##plotting unemploymrnt rates by year,
## with color blocks for each term represented by political party
##caption=title
#date=starting date (1960-01-01)
caption=paste(strwrap("Unemployment Rates in the U.S Have Varied a Lot Over the Years",40),
              collape ="\n")
yrng=range(e$unemploy)
xrng=range(e$date)
date=as.Date("1960-01-01")

ggplot(e) +
  geom_line(aes(x=date, y=unemploy))+
  geom_rect(data=pres, aes(xmin=start, xmax=end, fill=party),
            ymin=-Inf, ymax=Inf, alpha=0.2) +
  scale_fill_manual(values=c("dodgerblue","firebrick3")) +
  geom_vline(data=pres, aes(xintercept=as.numeric(start)),
             colour="grey50",alpha=0.5) +
  annotate("text",x=date, y=yrng[2], label=caption,
           hjust=0,vjust=1,size=4)


###Bar graph challenge
##stacked bar and used "group_by" function

load("fish_data.Rdata")
fs= fish %>% group_by(area_fac,depth_fac, yr_fac) %>%
  summarise(parcel.count=length(parcel.id))
fs

ggplot(fs) +
  geom_bar(aes(x=area_fac, y=parcel.count, fill=depth_fac),
           position = "stack",
           stat="identity") +
  facet_grid(yr_fac~.)

##grouped bars

ggplot(fs) +
  geom_bar(aes(x= area_fac, y= parcel.count, fill=depth_fac),
           position="dodge",
           stat="identity")

##using facet wrap to get all bars on same plot
ggplot(fs) +
  geom_bar(aes(x = yr_fac, y=parcel.count,
               fill = depth_fac),
           position = "stack",
           stat = "identity") +
  facet_wrap(~area_fac) ##separates graphs by area_fac, and plots all 4 areas on the same plot

