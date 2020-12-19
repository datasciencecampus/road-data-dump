"
function of script:
Parse JSON response and extract content for all responses that did not return an error
or did not return a 204: no content
assign site_id column form pattern matching siteID query parameter in response url
"
info(my_logger, paste0("#############", "Start of", this.path(), "#############"))



# parallel ----------------------------------------------------------------
# Error encountered: writing to object.
# Commented out for future development.
# # make a cluster with the number of cores found
# cl <- makeCluster(ncores)
# # export dependencies to the clusters
# clusterExport(cl, c("request_results", "MAX_ROWS"))
# # load required libraries in the clusters
# clusterEvalQ(cl, {
#   library(jsonlite)
#   library(stringr)
# })
# 
# # assign site Ids
# # list all data from response content
# report_data <- parLapply(cl, request_results, handle_report)
# 
# # kill the cluster
# stopCluster(cl)
# parallel ----------------------------------------------------------------



# assign site Ids
# list all data from response content

report_data <- lapply(request_results, handle_report)




# tidy up -----------------------------------------------------------------

rm(list = c("request_results", "cl", "ncores"))


# memory report -----------------------------------------------------------

memory_report()
