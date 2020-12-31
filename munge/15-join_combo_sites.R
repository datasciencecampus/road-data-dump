"Purpose of script:
join readings and sites
"
log4r::info(my_logger, paste0("############# ", "Start of ", current_file(), " #############"))
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
  saveRDS(nullmatch_combo, "cache/nullmatch_combo.RDS")
}

"
null matches in sites, NB not as important as null matches in combo, as
many of these will be due to HTTP 204: empty response. Therefore, not 
currently pursued. If needed, sites$sites.Id could be checked against
matches in c(combo$site_id, cache/site_Id_204s.rds), this rds is created
upstream wihtin this pipeline though.
"



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
