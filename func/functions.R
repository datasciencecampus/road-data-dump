"
Purpose of script:
Contain custom functions for use in munge processing scripts
"

# 05-GET_sitetypes.R handle_query ------------------------------------------------------------

handle_query <- function(GET_result, resource, site) {
  if (http_error(GET_result)) {
    log4r::info(my_logger, paste("###########GET", resource, "for Site", site, "###########"))
    log4r::info(my_logger, paste("Site", site, "queried url:", GET_result$url))
    log4r::info(my_logger, paste("Date of query:", GET_result$date))
    log4r::info(my_logger, paste("Query durations", capture.output(GET_result$times)))
    log4r::info(my_logger, paste("Query status message:", http_status(GET_result)))
    log4r::warn(my_logger, "The GET() request failed")
    log4r::warn(my_logger, paste("HTTP Status code:", GET_result$status_code))
  } else {
    log4r::info(my_logger, paste("###########GET", resource, "for Site", site, "###########"))
    log4r::info(my_logger, paste("###########", resource, "successfully queried for Site", site, "###########"))
    log4r::info(my_logger, paste("Site", site, "queried url:", GET_result$url))
    log4r::info(my_logger, paste("Date of query:", GET_result$date))
    log4r::info(my_logger, paste("Query durations", capture.output(GET_result$times)))
    log4r::info(my_logger, paste("HTTP status code:", GET_result$status_code))
    #
    df_output <- data.frame(
      fromJSON(
        rawToChar(
          GET_result$content
        ), # parse JSON as text
        flatten = TRUE
      ) # coerce to list
    ) # coerce to dataframe
  }
  return(df_output)
}
# End of handle_query ------------------------------------------------------------

# end of 05-GET_sitetypes.R handle_query ------------------------------------------------------------


# 08-Get_daily_reports.R handle_errors ------------------------------------
# log any errors detected, if any are status code 500 to 599, assign a vector of retry_urls to
# global environment
handle_errors <- function(error_responses){
  warn(my_logger, "Errors detected in api responses")
  warn(my_logger, "Errors urls follow:")
  warn(my_logger, paste(unlist(list.select(error_responses, url)), collapse = "\n"))
  
  # filter bad requests
  bad_requests <- list.filter(error_responses, status_code >= 400 && status_code <= 499)
  if(length(bad_requests) > 0) {
  warn(my_logger, "Bad requests found.")
  warn(my_logger, "Bad request urls follow:")
  warn(my_logger, paste(unlist(list.select(bad_requests, url)), collapse = "\n"))
  }
  
  # filter internal api errors
  internal_errors <- list.filter(error_responses, status_code >= 500 && status_code <= 599)
  if(length(internal_errors) > 0) {
    warn(my_logger, "Internal api errors found.")
    warn(my_logger, "Urls to retry:")
    retry_these <- unlist(list.select(internal_errors, url))
    warn(my_logger, paste(retry_these, collapse = "\n"))
    assign("retry_urls", retry_these, envir = .GlobalEnv)
  }
}
# 08-Get_daily_reports.R handle_errors ------------------------------------


# 08-Get_daily_reports.R  handle_missing ----------------------------------

handle_missing <- function(GET_results) {

  # select all queries where status is 204 (no content but no error)
  response_204s <- list.filter(GET_results, status_code == 204)

  # select just the url from these null content responses
  url_204s <- unlist(list.select(response_204s, url))
  
  # catch all errors too
  api_errors <- list.filter(GET_results, status_code >= 400 && status_code <= 599)
  
  # log any errors detected, if any are status code 500 to 599, assign a vector of retry_urls to
  # global environment
  if(length(api_errors >0)){
  handle_errors(api_errors)
  }
  # urls for errors
  url_errors <- unlist(list.select(api_errors, url))
  
  
  # select all urls
  all_urls <- unlist(list.select(GET_results, url))
  number_urls <- length(all_urls)
  
  all_queried_siteIds <- sapply(
    all_urls,
    # extract just the siteIds, simplify to a vector
    # character match tested on https://regex101.com/ for varying digit sequences
    # pulls id from string, lookbehind (?<=) and look ahead (?=) so that
    # "sites=" and "&" is not included in the match
    # [0-9]+ matches any sequence of numbers with different lengths
    function(x) str_extract(x, pattern = "(?<=sites=)([0-9]+)(?=&)")
  )
  # write to cache for reporting
  saveRDS(all_queried_siteIds, "cache/all_queried_siteIds.rds")

# extract the 204 responses site IDs
  site_Id_204s <- sapply(
    url_204s,
    function(x) str_extract(x, pattern = "(?<=sites=)([0-9]+)(?=&)")
  )
  # write to cache for reporting
  saveRDS(site_Id_204s, "cache/site_Id_204s.rds")
  
  # count the number of 204s
  number_204s <- length(site_Id_204s)

  site_Id_errors <- sapply(
    url_errors,
    function(x) str_extract(x, pattern = "(?<=sites=)([0-9]+)(?=&)")
  )
  # count the number of errors
  number_errors <- length(site_Id_errors)
  
  # write to cache for reporting if errors are detected
  if(number_errors > 0) {
  saveRDS(site_Id_errors, "cache/site_Id_errors.rds")
  }
  
  # find urls that are not responsible for 204 statuses or errors
  urls_not204 <- setdiff(all_urls, c(url_204s, url_errors))

  # filter the request results based on the above. Only these will be parsed.
  reqs_not_204 <- list.filter(GET_results, url %in% urls_not204)

# test number of IDs ------------------------------------------------------
  if(number_urls != number_204s + number_errors + length(urls_not204)) {
    warn(my_logger, paste("Problem found at", current_file()))
    warn(my_logger, "Checking total url count against 200s, 204s and errors")
    warn(my_logger, paste("Count of all urls is", number_urls))
    warn(my_logger, paste("Count of 200s, 204s & errors is",
                          number_204s + number_errors + length(urls_not204)))
    warn(my_logger, "May indicate response codes not currently tested for. Check logs!")
  }

  # create filenames --------------------------------------------------------


  # get the numbers from the daterange whether a test run or not
  dates_used <- paste(unlist(str_extract_all(daterange, "[0-9]+")), collapse = "to")
  # write to cache for reporting
  saveRDS(dates_used, "cache/dates_used.rds")
  
  suffix <- paste0(dates_used, ".txt")

  if (test_run == TRUE) {
    write.table(print(paste(
      "Test run: Missing data report ",
      "Number of missing IDs (204s) for test run: ",
      number_204s,
      " Total number of sites queried: ",
      number_urls,
      " Proportion of Site IDs that were missing (204s) for test run: ",
      round(number_204s / number_urls, digits = 2),
      ". Site Ids that returned no content :",
      paste(site_Id_204s, collapse = ","),
      ". Date period queried: ",
      daterange,
      sep = "\n"
    )),
    file = paste0("output_data/test-missing_site_IDs", suffix)
    )
  } else {
    write.table(print(paste(
      "Missing data report ",
      "Number of missing IDs (204s) for this run: ",
      number_204s,
      " Total number of sites queried: ",
      number_urls,
      " Proportion of Site IDs that were missing (204s) for this run: ",
      round(number_204s / number_urls, digits = 2),
      ". Site Ids that returned no content :",
      paste(site_Id_204s, collapse = ","),
      ". Date period queried: ",
      daterange,
      sep = "\n"
    )),
    file = paste0("output_data/missing_site_IDs", suffix)
    )
  }

  # log the site errors if they exist
  if (length(site_Id_errors >= 1)) {
    warn(my_logger, "Removing errors from api request results:")
    warn(my_logger, site_Id_errors)
  }
  return(reqs_not_204)
}

# End of 08-Get_daily_reports.R  handle_missing ----------------------------------


# 09-retry_internal_errors.R ----------------------------------------------
slow_retry <- function(urls, user_details){
  Sys.sleep(0.5)
  GET(url = urls, user_agent(user_details))
}

slower_retry <- function(urls, user_details){
  Sys.sleep(1)
  GET(url = urls, user_agent(user_details))
}

slowest_retry <- function(urls, user_details){
  Sys.sleep(3)
  GET(url = urls, user_agent(user_details))
}

# End of 09-retry_internal_errors.R ----------------------------------------------


# 10-parse_present_data.R --------------------------------------------------

handle_report <- function(GET_result) {

  # coerce response to list
  listed_JSON <- fromJSON(
    rawToChar(
      unlist(GET_result$content)
    ), # parse JSON as text
    flatten = TRUE
  )

  # use pattern matching to extract the site ID from the queried url
  site_id <- str_extract(GET_result$url, pattern = "(?<=sites=)([0-9]+)(?=&)")
  # write to a new column in the list
  listed_JSON$Rows$site_id <- site_id
  
  

  # need to convert with as.data.frame or data.table once all JSON returned
  return(listed_JSON$Rows)
}

# End of 10-parse_present_data.R --------------------------------------------------