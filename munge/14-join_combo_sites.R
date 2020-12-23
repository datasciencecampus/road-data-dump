"Purpose of script:
join readings and sites
"
wrap_up()

info(my_logger, paste0("#############", "Start of", this.path(), "#############"))
gc()
combo <- cbind(combo, sites[mapping, -(1:3)])


# clean up leaving readings only
rm(list = c(
  "sites",
  "mapping",
  "direction",
  "easting_northing"
))

# memory report -----------------------------------------------------------
memory_report()
