# extract eastings northings ----------------------------------------------




sites <- cbind(sites, easting_northing(sites$name))


# mapping for join to readings --------------------------------------------

# combine site info with readings, split into midas, tame, tmu files
# sensor reading -> sensor mapping
mapping <- match(readings$site_id, sites$id)


gc()
#**todo** need to do this in chunks as to save memory
# glue together

