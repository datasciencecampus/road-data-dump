"
function of script:
Parse JSON response and extract content for all responses that did not return an error
or did not return a 204: no content
assign site_id column form pattern matching siteID query parameter in response url
"
info(my_logger, paste0("#############", "Start of", this.path(), "#############"))

# assign site Ids
# list all data from response content
report_data <- lapply(request_results, handle_report)


# tidy up -----------------------------------------------------------------

rm(request_results)


# memory report -----------------------------------------------------------

memory_report()
