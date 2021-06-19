"Purpose of script:
Extract eastings and northings
"
log4r::info(my_logger, paste0("############# ", "Start of ", basename(this.path()), " #############"))

# extract eastings northings ----------------------------------------------
'find the pattern locations
This matches lines like this:
"MIDAS site at M4/2295A2 priority 1 on link 105009001; GPS Ref: 502816;178156; Westbound"
but not lines like this:
"TMU 7069/1 on A1(M) northbound between J42 and J43 on road A1(M) Northbound at location 53.792111151099000,-1.322338625921000"
'
sites <- cbind(sites, easting_northing(sites$sites.Name))

# tidy up -----------------------------------------------------------------
rm(easting_northing)

# memory report -----------------------------------------------------------
memory_report()