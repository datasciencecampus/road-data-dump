"
function of script:
Parse JSON response and extract content for all responses that did not return an error
or did not return a 204: no content
assign site_id column form pattern matching siteID query parameter in response url
"
log4r::info(my_logger, paste0("############# ", "Start of ", basename(this.path()), " #############"))


# assign site Ids
# list all data from response content
# only execute if queried dates are not empty
# if(pipeline_message != stat_codes[3]){
# report_data <- lapply(request_results, handle_report)
# }


# tidy up -----------------------------------------------------------------

rm(list = c(
  # "request_results",
  # "handle_report",
  # "agent_message",
  # "end_date",
  "ENDPOINT",
  "MAX_ROWS",
  "RESOURCES",
  # "start_date",
  "user_details"))


# memory report -----------------------------------------------------------

# memory_report()
