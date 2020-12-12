'
function of script:
Get daily reports for all discovered site Ids
'
info(api_logger, "#############New Daily report request#############")
current_queries <- all_urls[1:10]

# The below works for the first 5 queries
# testing at scale, 100, Time difference of 21.69305 secs
# testing all Ids, 16165 Ids... stopped at 33 minutes.
# Looks like it's going to take an hour for all 16.5k

# GET daily reports -------------------------------------------------------
info(api_logger, "Duration of all site ID daily report request")
report_start <- Sys.time()
request_results <- lapply(X = current_queries, FUN = function(x) GET(url = x, user_agent(user_details)))
info(api_logger, paste("Duration of report request: ", capture.output(Sys.time() - report_start)))



# filter out 204s ---------------------------------------------------------

# filter out any requests that returned a 204 status with missing content
# print out a text file with their IDs to output_data/missing_site_IDs.txt
present_requests <- handle_missing(request_results)



# remove any errors -------------------------------------------------------



# working -----------------------------------------------------------------


listed_responses <- present_requests[5]

handle_report <- function(listed_responses) {

retry_urls <- c()
this_statcode <- unlist(list.select(listed_responses, status_code))
this_url <- unlist(list.select(listed_responses, url))

if(
  between(
    # is the status code anything starting with 4** - bad request
    this_statcode, left = 400, right = 499
    )
) {
  warn(my_logger, "Removing errors from api request results:")
  warn(my_logger, paste("Bad request for url: ", this_url))
  warn(my_logger, "Skipping url")
  next
} else if(
  between(
    # is the status code anything starting with 5** - internal server error
    this_statcode, left = 500, right = 599
    )
) {
  warn(my_logger, "Internal Server Error Detected:")
  warn(my_logger, paste("Internal Server Error for url: ",
                        this_url))
  warn(my_logger, "Storing url for retry.")
  warn(my_logger, this_url)
  #store this with the rest of retry urls
  retry_urls <- c(retry_urls, this_url)
  warn(my_logger, paste("retry_urls is currently", length(retry_urls), "url(s) long."))
} else if(
  # Check to ensure only parsing responses with a 200 code
  this_statcode == 200) {
  # coerce response to list
  listed_JSON <- fromJSON(
    # coerce to character
    rawToChar(unlist(list.select(listed_responses, content))),
    flatten = TRUE)
  # control flow if row limit is hit.
  if(listed_JSON$Header$row_count > MAX_ROWS){
    warn("Maximum rows exceeded. Use HTTP pagination.")
  }
  #coerce to dataframe
  df_output <- as.data.frame(listed_JSON$Rows)
  # assign site_id
  df_output$site_id <- site
}

}


present_content <- lapply(present_requests, handle_report)



# working -----------------------------------------------------------------



# tidy up -----------------------------------------------------------------

rm(list = c(
  "request_results",
  "all_urls"
))




# memory report -----------------------------------------------------------

memory_report()



# wrap_up -----------------------------------------------------------------

wrap_up()