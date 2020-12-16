"
function of script:
Get daily reports for all discovered site Ids
"
info(my_logger, paste0("#############", "Start of", this.path(), "#############"))

# The below works for the first 5 queries
# testing at scale, 100, Time difference of 21.69305 secs
# testing all Ids, 16165 Ids... stopped at 33 minutes.
# Looks like it's going to take an hour for all 16.5k

# GET daily reports -------------------------------------------------------
info(my_logger, "Duration of all site ID daily report request")
report_start <- Sys.time()
request_results <- lapply(X = all_urls, FUN = function(x) GET(url = x, user_agent(user_details)))
info(my_logger, paste("Duration of report request: ", capture.output(Sys.time() - report_start)))


# tally the status codes returned and log them
info(my_logger, capture.output(table(unlist(list.select(request_results, status_code)))))


# remove 204s and errors --------------------------------------------------
# filter out any requests that returned a 204 status with missing content
# print out a text file with their IDs to output_data/missing_site_IDs.txt

request_results <- handle_missing(request_results)



# tidy up -----------------------------------------------------------------

rm(all_urls)




# memory report -----------------------------------------------------------

memory_report()
