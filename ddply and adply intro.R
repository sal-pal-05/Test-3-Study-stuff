library(tidyverse)
load("fish_data.Rdata")

#ddply
ddply(.data =fish, .variables ="transect.id", function(x){
  
}, .progress ="text")

##adply

#list all the physical data files in a given directory
batch_data = list.files (paste0("batch_data/"), full=TRUE, pattern ="ISIIS")
batch_data

phy=adply(batch_data, 1, function(file){
  
#read in the data
  d=read.table(batch_data[1], sep="\t", skip=10, header=TRUE, fileEncoding = "ISO-8859-1",
               stringsAsFactors = FALSE, quote="\"", check.names=FALSE, encoding="UTF-8",
               na.strings = "9999.99")


##clean names
head=names(d)
head=str_replace(head, "\\(.*\\)", "")
head=str_trim(head)
head=make.names(head)
head=tolower(head)
head=str_replace(head, fixed (".."), ".")

#assign names

names(d)=head

##create proper date+time format
date=scan(batch_data[1], what="character", skip=1, quiet=TRUE)
d$date=date[2]

d$dateTime=str_c(d$date, d$time, sep=" ")

d$dateTime=as.POSIXct(strptime(d$dateTime, format="%m/%d/%y %H:%M:%OS", tz="America/New_York"))

return(d)

}, .progress="text")