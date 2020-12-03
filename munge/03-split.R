"Purpose of script: split files processed in prep.R by site"

# run the prep.R script
source("prep.R")

#split into midas,tame,tmu

# The below line was responsible for dropping the 2 named columns in the original code
# keep.cols <- ! colnames(readings) %in% c("type", "status")


midas <- readings[readings$type == "midas"]
tame <- readings[readings$type == "tame"]
tmu <- readings[readings$type == "tmu"]

rm(readings)
gc()

# not sure why, but I have no readings for tmu and tame
# nrow(midas)
# nrow(tame)
# nrow(tmu)
# 19964064
# 2416320
# 6399360

"toggled back to old direction function and back, no affect on tame & tmu observations.Suggest 
it's due to inconsistent output of bash script"

fwrite(midas, "../output/midas.csv", row.names=F, quote=F)
fwrite(tame, "../output/tame.csv", row.names=F, quote=F)
fwrite(tmu, "../output/tmu.csv", row.names=F, quote=F)


# sound alert when script completes
beep("coin")
