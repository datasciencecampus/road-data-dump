"Purpose of script:
join readings and sites
"

combo <- cbind(combo, sites[mapping, -(1:3)])
#readings[sample(1:nrow(readings), 10), ]
#**warning** ^-- pushed R instance to ~70g memory. good job i have swap on an NVMe stick..


#clean up leaving readings only
remove(list = c("site_midas",
                "site_tame",
                "site_tmu",
                "sites",
                "mapping",
                "direction",
                "easting_northing"))

gc(verbose = TRUE,
   reset = TRUE,
   full = TRUE)