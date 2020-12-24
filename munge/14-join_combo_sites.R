"Purpose of script:
join readings and sites
"
info(my_logger, paste0("############# ", "Start of ", this.path(), " #############"))
gc()


# join integrity ----------------------------------------------------------
# find any site IDs in combo that have no corresponding ID in the sites df
null_matches <- setdiff(combo$site_id, sites$sites.Id)

# if null matches is not empty, log warnings and output data for site_report
if(length(null_matches) > 0){
  # log
  warn(my_logger, "There are unmatched IDs in the combo DataFrame")
  warn(my_logger, paste("Unmatched IDs found:",
                        paste0(null_matches, collapse = ", ")))
  # anti-join combo and output for site_report
  nullmatch_combo <- anti_join(combo, sites, by = c("site_id" = "sites.Id"))
  saveRDS(nullmatch_combo, "cache/nullmatches.RDS")
}


# execute join ------------------------------------------------------------
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
