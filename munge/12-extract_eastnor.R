"Purpose of script:
Extract eastings and northings
"
info(my_logger, paste0("#############", "Start of", this.path(), "#############"))
# extract eastings northings ----------------------------------------------


sites <- cbind(sites, easting_northing(sites$sites.Name))


# mapping for join to readings --------------------------------------------

# combine site info with readings, split into midas, tame, tmu files
# sensor reading -> sensor mapping
mapping <- match(combo$site_id, sites$sites.Id)


gc()
#** todo** need to do this in chunks as to save memory
# glue together
