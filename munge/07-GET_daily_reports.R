"
function of script:
Get daily reports for all discovered site Ids
"
info(my_logger, paste0("#############", "Start of", this.path(), "#############"))


# GET daily reports -------------------------------------------------------
info(my_logger, "Duration of all site ID daily report request")
report_start <- Sys.time()


# parallel ----------------------------------------------------------------
# get the number of cores available
ncores <- detectCores()
# make a cluster with the number of cores found
cl <- makeCluster(ncores)
# export dependencies to the clusters
clusterExport(cl, c("all_urls", "user_details"))
# load required libraries in the clusters
clusterEvalQ(cl, {
  library(httr)
})
# Get the responses in parallel
request_results <- parLapply(cl, all_urls, function(i) {
  GET(url = i, user_agent(user_details))
   })

# kill the cluster
stopCluster(cl)
# parallel ----------------------------------------------------------------

# logging parallel output -------------------------------------------------
n_urls <- length(all_urls)
n_results <- length(request_results)
# warn if there is a difference in number of urls and responses
if(n_urls != n_results){
  warn(my_logger, "Length of request results and length of urls are not equal.")
  warn(my_logger, paste("Number of urls to query:", n_urls))
  warn(my_logger, paste("Number of responses:", n_results))
}

info(my_logger,
     paste("Duration of report request: ", capture.output(Sys.time() - report_start)))


# tally the status codes returned and log them
info(my_logger,
     capture.output(table(unlist(list.select(request_results, status_code)))))


# remove 204s and errors --------------------------------------------------
# filter out any requests that returned a 204 status with missing content
# print out a text file with their IDs to output_data/missing_site_IDs.txt

request_results <- handle_missing(request_results)



# tidy up -----------------------------------------------------------------

rm(list = c("all_urls", "ncores", "n_urls", "n_results", "cl"))




# memory report -----------------------------------------------------------

memory_report()
