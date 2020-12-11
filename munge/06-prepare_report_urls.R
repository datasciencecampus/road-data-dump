"
Purpose of script:
Prepare the report URLs for api queries
based on available_site Ids from 05-available_siteIds.R
and parameters set in 03-set_query_parameters.R
Maximum of 30 siteIds to query at once
"

siteId <- all_sites[14311] #works fine


current_query <- paste0(ENDPOINT, RESOURCES[4], "?sites=", siteId, daterange, "&page=", page_no, "&page_size=", MAX_ROWS)

# tidy up -----------------------------------------------------------------
rm()


# memory report -----------------------------------------------------------
memory_report()

