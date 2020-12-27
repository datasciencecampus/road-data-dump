"
Purpose of script:
If any internal api errors (status code 500 to 599)
were found in script 08-GET_daily_reports.R handle_missing(),
a named character vector `retry_urls` will be assigned to the
.GlobalEnv, query these again more slowly and append back to
`request_results` ready for parsing.
"
wrap_up()
#hard code retry_urls for now as difficult to replicate
retry_urls <- unlist(list.select(request_results, url)) 

slow_retry <- function(urls){
  Sys.sleep(0.5)
  GET(url = urls, user_agent(user_details))
}

slower_retry <- function(urls){
  Sys.sleep(1)
  GET(url = urls, user_agent(user_details))
}

slowest_retry <- function(urls){
  Sys.sleep(3)
  GET(url = urls, user_agent(user_details))
}

# check for presence of retry_urls
if("retry_urls" %in% ls()){
  warn(my_logger, "Entering slow retry...")
  retried_results <- lapply(retry_urls, slow_retry)
  warn(my_logger, "results have been retried")
  warn(my_logger, "Status Codes Returned: ")
  warn(my_logger, paste(
    unlist(list.select(retried_results, status_code)), collapse = ", "))
}
