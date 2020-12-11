"
Purpose of script:
Prepare the report URLs for api queries
based on available_site Ids from 05-available_siteIds.R
and parameters set in 03-set_query_parameters.R
Maximum of 30 siteIds to query at once
"

siteId <- all_sites[14311] #works fine

# siteId <- all_sites[5684] # this is the one used in our own instructions


# siteId <- all_sites[666]

# siteId <- tail(all_sites, 1) # this didn't work, 204 status code, good request, no content

# siteId <- all_sites[1000] # as above


page_no <- 1

current_query <- paste0(ENDPOINT, RESOURCES[4], "?sites=", siteId, daterange, "&page=", page_no, "&page_size=", MAX_ROWS)

#current_query <- paste0(ENDPOINT, "/reports/daily?sites=8188&start_date=31032016&end_date=31032017&page=1&page_size=50")

# tidy up -----------------------------------------------------------------
rm()


# memory report -----------------------------------------------------------
memory_report()

