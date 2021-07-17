"Purpose of script:
join readings and sites
"
log4r::info(my_logger, paste0("############# ", "Start of ", basename(this.path()), " #############"))
gc()


# join integrity ----------------------------------------------------------
# find any site IDs in combo that have no corresponding ID in the sites df
if(pipeline_message != stat_codes[3]){
  
  combo_site_id <- combo %>% select(site_id) %>% as.data.frame()
  sites_site_id <- sites %>% select(site_id) %>% as.data.frame()
  
  null_matches <- setdiff(combo_site_id, sites_site_id)
  
  # if null matches is not empty, log warnings and output data for site_report
  if(length(null_matches) > 0){
  # log
  warn(my_logger, "There are unmatched IDs in the combo DataFrame")
  warn(my_logger, paste("Unmatched IDs found:",
  paste0(null_matches, collapse = ", ")))
  # anti-join combo and output for site_report
  nullmatch_combo <- anti_join(combo, sites, by = c("site_id")) %>% as.data.frame()
  saveRDS(nullmatch_combo, "cache/nullmatch_combo.RDS")
  # tidy up
  rm(list = c(
    "nullmatch_combo",
    "null_matches")
    )
  }
  # execute join ------------------------------------------------------------
  # join the site details to the sensor output on site ID, dropping 2 columns from the
  # site details df, row count and site name.
  combo <- left_join(combo, sites, by = c("site_id"))
  
}

"
null matches in sites, NB not as important as null matches in combo, as
many of these will be due to HTTP 204: empty response. Therefore, not 
currently pursued. If needed, sites$sites.Id could be checked against
matches in c(combo$site_id, cache/site_Id_204s.rds), this rds is created
upstream within this pipeline though.
"
# clean up leaving readings only
rm(list = c(
  "sites",
  "combo_site_id"
))

# memory report -----------------------------------------------------------
memory_report()