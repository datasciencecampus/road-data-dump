"
Purpose of script: Read in site data
"
# read sites ---------------------------------------------------------------

###site midas###
site.midas <- read.csv("../site_midas.csv", stringsAsFactor=F)

###site tame###
site.tame <- read.csv("../site_tame.csv", stringsAsFactor=F)

###site tmu###
site.tmu <- read.csv("../site_tmu.csv", stringsAsFactor=F)


# read data from webtri.sh ------------------------------------------------
#read in the actual data obtained from `webtri.sh
readings <- fread("../combo.csv", stringsAsFactor=F)

gc()
