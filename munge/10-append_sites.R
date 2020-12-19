"Purpose of script:
Append all sites
"
info(my_logger, paste0("#############", "Start of", this.path(), "#############"))

# create a type column and assign 'midas' as the value
site_midas$type <- "midas"

# create 'tame' label column
site_tame$type <- "tame"

# assign 'tmu' column label
site_tmu$type <- "tmu"


# combine site info
# row bind (append) all site data tables. Consistent format.
sites <- rbind(site_midas, site_tame, site_tmu)

sitetypes <- select(sites, row_count, sites.Id,sites.Description, sites.Status, type)
# save to cache for reporting
saveRDS(sitetypes, "cache/sitetypes.rds")

# tidy up -----------------------------------------------------------------

rm(list = c(
  "site_midas",
  "site_tame",
  "site_tmu",
  "sitetypes"
))

# memory_report() ---------------------------------------------------------

memory_report()
