"Purpose of script:
Append all sites
"

log4r::info(my_logger, paste0("############# ", "Start of ", basename(this.path()), " #############"))

# create a type column and assign 'midas' as the value
site_midas$type <- "midas"

# create 'tame' label column
site_tame$type <- "tame"

# assign 'tmu' column label
site_tmu$type <- "tmu"


# combine site info
# row bind (append) all site data tables. Consistent format.
sites <- rbind(site_midas, site_tame, site_tmu)



# logging for sites -------------------------------------------------------
handle_df(sites)

# check sites against constituent parts
nrow(sites) == nrow(site_midas) + nrow(site_tame) + nrow(site_tmu)

# combine all unique constituent column names
site_cols <- unique(c(names(site_midas), names(site_tame), names(site_tmu)))
sites_cols <- names(sites)
expected_cols <- c("row_count", "sites.Id", "sites.Name",
                   "sites.Description", "sites.Longitude", "sites.Latitude",
                   "sites.Status", "type")

# get unexpected column names
site_unexp <- setdiff(site_cols, expected_cols)
sites_unexp <- setdiff(sites_cols, expected_cols)

if(length(site_unexp) > 0){
  warn(my_logger, paste("Issue found at", current_file()))
  warn(my_logger, paste("Unexpected column names found in site DFs."))
  warn(my_logger, paste("Columns are:", paste(site_unexp, collapse = ", ")))
} else if(length(sites_unexp) > 0){
  warn(my_logger, paste("Issue found at", current_file()))
  warn(my_logger, paste("Unexpected column names found in sites DF."))
  warn(my_logger, paste("Columns are:", paste(sites_unexp, collapse = ", ")))
}

# cache for site_report ---------------------------------------------------
sitetypes <- select(sites, row_count, sites.Id, sites.Name, sites.Description, sites.Status, type)
# save to cache for reporting
saveRDS(sitetypes, "cache/sitetypes.rds")

# tidy up -----------------------------------------------------------------
rm(list = c(
  "site_midas",
  "site_tame",
  "site_tmu",
  "sitetypes",
  "site_cols",
  "sites_cols",
  "site_unexp",
  "sites_unexp",
  "expected_cols"
))

# memory_report() ---------------------------------------------------------
memory_report()
