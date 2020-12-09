"
Purpose of script:
Prepare the report URLs for api queries
based on available_site Ids from 05-available_siteIds.R
and parameters set in 03-set_query_parameters.R
Maximum of 30 siteIds to query at once
"

id_batches <- lapply(id_chunks, make_batches)


paste0(ENDPOINT, RESOURCES[4], "?sites=", id_batches[1], daterange, "&page=1&page_size=", MAX_ROWS)

# tidy up -----------------------------------------------------------------
rm(id_chunks)


# memory report -----------------------------------------------------------
memory_report()
