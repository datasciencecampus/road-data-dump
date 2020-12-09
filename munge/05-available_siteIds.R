'
Purpose of script:
Step 5.Get all the site IDs.
This is achieved by concatenating siteIds from all 3 site dataframes
'
all_sites <- c(site.midas$sites.Id,
               site.tame$sites.Id,
               site.tmu$sites.Id)

info(my_logger, paste0("###########All Site Ids###########"))


# check for any duplicate sites
info(my_logger, paste0("Duplicated site Ids: ",  all_sites[duplicated(all_sites)]))


# count the number of site Ids
info(my_logger, paste0("Number of Site Ids: ",  length(all_sites)))

# count the number of site Ids
info(my_logger, paste0("Number of distinct Ids: ",  n_distinct(all_sites)))


if (length(all_sites) != n_distinct(all_sites)) {
  warn(my_logger, "Warning, not all Site Ids from Midas, Tame & TMU are distinct")
}