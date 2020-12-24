"Purpose of script:
join readings and sites
"
info(my_logger, paste0("#############", "Start of", this.path(), "#############"))
gc()
# join the site details to the sensor output on site ID, dropping 2 columns from the
# site details df, row count and site name.
combo <- left_join(combo, sites[, -(c(1,3))], by = c("site_id" = "sites.Id"))


# clean up leaving readings only
rm(list = c(
  "sites",
  "direction",
  "easting_northing"
))

# memory report -----------------------------------------------------------
memory_report()
