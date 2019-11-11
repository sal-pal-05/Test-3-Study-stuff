##for loops
# starting with temperature conversion

t= data.frame (f_deg=seq (0,100,1))
t$c_deg=NA
t$k_deg=NA


##for every number"i" in the data frame, starting at row 1 and ending with however many rows the DF has,
##to convert it to c_deg, apply that function, and to convert to k_deg, apply the other function
for(i in 1:nrow(t)){
  
 t[i,]$c_deg =(t[i,]$f_deg -32) * (9/5)
 t[i,]$k_deg =(t[i,]$c_deg +273.15)
  
}

##for every number"i", starting from the 1st row in the DF to the 10th Row in the DFapply 
##the converstion functions

for(i in 1:10){
  
  t[i,]$c_deg =(t[i,]$f_deg -32) * (9/5)
  t[i,]$k_deg =(t[i,]$c_deg +273.15)
  
}


##combining for loop with "if else"

m=data.frame(f_deg=seq(0,100,1))
m$c_deg=NA
m$k_deg=NA
m$rel_temp=NA

for(i in 1:nrow(m)){
  m[i,]$c_deg=(m[i,]$f_deg - 32) * (9/5)
  m[i,]$k_deg=(m[i,]$c_deg + 273.15)
  
  m[i,]$rel_temp=ifelse(test=m[i,]$c_deg < 0,
                        yes="cold",
                        no="not cold") ## if the values of "c_deg" is <0, it will display as "cold" in the newly created column"rel_temp" (and #'s>0 will be "not cold")
}


########
s=data.frame(f_deg=seq(0,100,1))
s$c_deg=NA
s$k_deg=NA
s$rel_temp=NA

snek=function(x){
  
  if(x<=0)
    s[i,]$rel_temp="frozen"
  
  else if (x>0 & x<=50)
    s[i,]$rel_temp="cold"
  
  else if (x>50 & x<=70)
s[i,]$rel_temp="warm"

else
  s[i,]$rel_temp="hot"
}

view(s)


for(i in 1:nrow(s)){
  s[i,]$c_deg=(s[i,]$f_deg - 32) * (9/5)
  s[i,]$k_deg=(s[i,]$c_deg + 273.15)
  s[i,]$rel_temp=snek(x=s[i,]$c_deg)
}

view(s)


##Example 1 making your own for loop to convert from g-> mg ->ug
##making a data frame to convert from grams to micrograms
##Also remember, that for the function to run, the object in the function"i" must have a value prior to running the function.

i=1

v=data.frame(mass_g=seq(0,100,1))

v$mil_g=NA
v$mic_g=NA


for (i in 1:nrow(v)){
  
  v[i,]$mil_g=(v[i,]$mass_g /1000)
  v[i,]$mic_g=(v[i,]$mass_g / 1000000 )
}

view(v)



y= seq(1,10, 0.5)
x= seq(1,20,1)

d= data.frame(interation=seq(1,10,0.5))
for (i in 1:length(y)) {
  
  for(k in 1:19) {
    d$output=y[i]+x[k]
    
  }
}
d

patch.list=list()
max.brks.index=nrow(brks)







