"Purpose of script:
join readings and sites
"
info(my_logger, paste0("#############", "Start of", this.path(), "#############"))
gc()
combo <- cbind(combo, sites[mapping, -(1:3)])
# readings[sample(1:nrow(readings), 10), ]
#** warning** ^-- pushed R instance to ~70g memory. good job i have swap on an NVMe stick..


# clean up leaving readings only
rm(list = c(
  "sites",
  "mapping",
  "direction",
  "easting_northing"
))



# memory report -----------------------------------------------------------
memory_report()
