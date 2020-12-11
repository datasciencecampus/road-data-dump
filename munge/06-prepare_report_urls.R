"
Purpose of script:
Prepare the report URLs for api queries
based on available_site Ids from 05-available_siteIds.R
and parameters set in 03-set_query_parameters.R
Maximum of 30 siteIds to query at once
"



all_urls <- sapply(all_sites,
                   # creates all required query strings for every site_id
                   function(x) paste0(
                     ENDPOINT,
                     RESOURCES[4],
                     "?sites=",
                     x,
                     daterange, "&page=", page_no, "&page_size=", MAX_ROWS))


# tidy up -----------------------------------------------------------------
rm(all_sites)


# memory report -----------------------------------------------------------
memory_report()
