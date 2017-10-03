#Set our working directory. 
#This helps avoid confusion if our working directory is 
#not our site because of other projects we were 
#working on at the time. 
#Install packages
packs<-c("flexdashboard","tidyr","kableExtra","genoPlotR")
lapply(packs,require,character.only=T)

setwd("~/Documents/University_of_Minnesota/Wackett_Lab/github/blt/")

#render your sweet site. 
rmarkdown::render_site()