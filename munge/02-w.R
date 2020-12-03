# data manipulation -------------------------------------------------------

#create a type column and assign 'midas' as the value
site.midas$type <- "midas"

#create 'tame' label column
site.tame$type <- "tame"

#assign 'tmu' column label
site.tmu$type <- "tmu"


#combine site info
#row bind (append) all site data tables. Consistent format.
sites <- rbind(site.midas, site.tame, site.tmu)
