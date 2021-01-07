"
Purpose of script:
If any internal api errors (status code 500 to 599)
were found in script 08-GET_daily_reports.R handle_missing(),
a named character vector `retry_urls` will be assigned to the
.GlobalEnv, query these again more slowly and append back to
`request_results` ready for parsing.
"
log4r::info(my_logger, paste0("############# ", "Start of ", current_file(), " #############"))


# check for presence of retry_urls

# slow retry --------------------------------------------------------------
# if detected enter slow retry
if("retry_urls" %in% ls()){
  warn(my_logger, "Entering slow retry...")
  retried_results <- lapply(retry_urls, slow_retry)
  warn(my_logger, paste(length(retried_results), "results have been retried"))
  warn(my_logger, "Status codes returned following slow retry: ")
  warn(my_logger, paste(
    unlist(list.select(retried_results, status_code)), collapse = ", "))
  # assign to caught_retries any 200s or 204s
  caught_retries <- list.filter(retried_results,
                                status_code == 200 | status_code == 204)
  warn(my_logger, paste(length(caught_retries),
                        "results have been caught following slow retry"))
  # try another catch for a slower pass
  retry_urls2 <- unlist(list.select(list.filter(
    retried_results, status_code >= 500 && status_code <= 599),
              url))
  warn(my_logger, paste("number of urls to retry slower:", length(retry_urls2)))
  rm(list = c(
    "retry_urls",
    "retried_results"
    ))
}

# slower retry ------------------------------------------------------------

# if retry_urls2 is greater than 0, enter slower retry
# append any caught responses from the previous slow retry
if("retry_urls2" %in% ls()){
  warn(my_logger, "Entering slower retry...")
  retried_results <- lapply(retry_urls2, slower_retry)
  warn(my_logger, paste(length(retried_results), "results have been retried"))
  warn(my_logger, "Status codes returned following slower retry: ")
  warn(my_logger, paste(
    unlist(list.select(retried_results, status_code)), collapse = ", "))
  # assign to caught_retries any 200s or 204s
  caught_retries2 <- list.filter(retried_results,
                                status_code == 200 | status_code == 204)
  warn(my_logger, paste(length(caught_retries2),
                        "results have been caught following slower retry"))
  # append to caught_retries
  caught_retries <- list.append(caught_retries, caught_retries2)
  
  # try another catch for a slower pass
  retry_urls3 <- unlist(list.select(list.filter(
    retried_results, status_code >= 500 && status_code <= 599),
    url))
  warn(my_logger, paste("number of urls to retry slowest:", length(retry_urls3)))
  rm(list = c(
    "retry_urls2",
    "retried_results",
    "caught_retries2"
    ))
}


# slowest retry -----------------------------------------------------------

# if retry_urls3 is greater than 0, enter slowest retry
# append any caught responses from the previous slowest retry
if("retry_urls3" %in% ls()){
  warn(my_logger, "Entering slowest retry...")
  retried_results <- lapply(retry_urls3, slowest_retry)
  warn(my_logger, paste(length(retried_results), "results have been retried"))
  warn(my_logger, "Status codes returned following slowest retry: ")
  warn(my_logger, paste(
    unlist(list.select(retried_results, status_code)), collapse = ", "))
  # assign to caught_retries any 200s or 204s
  caught_retries3 <- list.filter(retried_results,
                                 status_code == 200 | status_code == 204)
  warn(my_logger, paste(length(caught_retries3),
                        "results have been caught following slowest retry"))
  # append to caught_retries
  caught_retries <- list.append(caught_retries, caught_retries3)
  
  # try another catch and output to logs
  retry_urls4 <- unlist(list.select(list.filter(
    retried_results, status_code >= 500 && status_code <= 599),
    url))
  warn(my_logger, paste("number of urls not caught at slowest retry",
                        length(retry_urls4)))

# append caught retries to request results --------------------------------
if("caught_retries" %in% ls()){
request_results <- c(request_results, caught_retries)
}
  
  wrap_up()
# tidy up -----------------------------------------------------------------
  
  rm(list = c(
    "retry_urls4",
    "retried_results",
    "caught_retries3"
    ))
}

rm(list = c(
  "slow_retry",
  "slower_retry",
  "slowest_retry"
))