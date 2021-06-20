"
Purpose of script:
Prepare the report URLs for api queries
based on available_site Ids from 05-available_siteIds.R
and parameters set in 03-set_query_parameters.R
Maximum of 30 siteIds to query at once
"
log4r::info(my_logger, paste0("############# ", "Start of ", basename(this.path()), " #############"))

# get only one report if testing
if (test_run == TRUE) {
  daterange <- "&start_date=01072019&end_date=01072019"
  all_urls <- paste0(
    ENDPOINT,
    RESOURCES[4],
    "?sites=",
    all_sites,
    daterange,
    "&page=", page_no, "&page_size=", MAX_ROWS
  )
} else {
  all_urls <- sapply(
    all_sites,
    # creates all required query strings for every site_id
    function(x) {
      paste0(
        ENDPOINT,
        RESOURCES[4],
        "?sites=",
        x,
        daterange, "&page=", page_no, "&page_size=", MAX_ROWS
      )
    }
  )
}


# logging prior to pinchpoint ---------------------------------------------

log4r::info(my_logger, "#####Pre-pinchpoint logging#####")
log4r::info(my_logger, paste("Number of queries:",
                             format(length(all_urls), scientific = FALSE, big.mark = ",")
                             ))

# tidy up -----------------------------------------------------------------
rm(all_sites)

# memory report -----------------------------------------------------------
memory_report()
