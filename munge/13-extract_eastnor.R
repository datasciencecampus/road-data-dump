"Purpose of script:
Extract eastings and northings
"
info(my_logger, paste0("#############", "Start of", this.path(), "#############"))
# extract eastings northings ----------------------------------------------
sites <- cbind(sites, easting_northing(sites$sites.Name))

# memory report -----------------------------------------------------------
memory_report()