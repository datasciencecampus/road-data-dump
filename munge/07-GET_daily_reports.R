'
function of script:
Get daily reports for all discovered site Ids
'
info(api_logger, "#############New Daily report request#############")
current_queries <- all_urls[1:5]

# The below works for the first 5 queries
# testing at scale, 100, Time difference of 21.69305 secs
# testing all Ids, 16165 Ids... stopped at 33 minutes.
# Looks like it's going to take an hour for all 16.5k

# GET daily reports -------------------------------------------------------
info(api_logger, "Duration of all site ID daily report request")
report_start <- Sys.time()
request_results <- lapply(X = current_queries, FUN = function(x) GET(url = x, user_agent(user_details)))
info(api_logger, paste("Duration of report request: ", capture.output(Sys.time() - report_start)))


# remove 204s and errors --------------------------------------------------
# filter out any requests that returned a 204 status with missing content
# print out a text file with their IDs to output_data/missing_site_IDs.txt
request_results <- handle_missing(request_results)



# tidy up -----------------------------------------------------------------

rm(all_urls)




# memory report -----------------------------------------------------------

memory_report()