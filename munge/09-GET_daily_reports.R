"
function of script:
Get daily reports for all discovered site Ids
"
log4r::info(my_logger, paste0("############# ", "Start of ", basename(this.path()), " #############"))

# GET daily reports -------------------------------------------------------
log4r::info(my_logger, "Duration of all site ID daily report request")

report_start <- Sys.time()


dates_used <- paste(unlist(str_extract_all(daterange, "[0-9]+") 
                           %>% as_vector() 
                           %>% as.Date(format="%d%m%Y") 
                           %>% format("%d-%m-%Y")), 
                    collapse = "_to_")

suffix <- paste0(dates_used, ".txt")

write.table(print(paste("-----------------")),
            file = paste0("output_data/missing_site_IDs_", suffix),
            append = FALSE, row.names = FALSE, col.names = FALSE)

# parallel ----------------------------------------------------------------
doFuture::registerDoFuture()
n_cores <- parallel::detectCores() - 1

future::plan(
  strategy = cluster,
  workers  = parallel::makeCluster(n_cores),
  gc = TRUE
)

get_url <- function(id){
  request <- RETRY(verb = "GET", url = id, user_agent(user_details))
  return(request)
  gc()
}

# Get the responses in parallel
info(my_logger, "Pinchpoint: Cluster queries all urls")

all_urls_nested_list_n = length(all_urls_nested_list)
all_requests_tables <- list()

for (chunk in 1:all_urls_nested_list_n){
  
  name <- paste("chunk_", chunk, sep = "")
  
  all_requests_tables[[name]] <- (future_map(all_urls_nested_list[[chunk]], get_url, .progress = TRUE) 
                                  %>% handle_missing
                                  %>% map(., handle_report)
                                  %>% list.stack(., data.table = TRUE)
                                  %>% tibble()
                                  %>% as.disk.frame()
  )
  
  gc()
  
}

plan(strategy = sequential)

info(my_logger, "Pinchpoint over: Cluster queries all urls")

if (map(all_requests_tables, nrow) 
    %>% as_tibble() 
    %>% sum() == 0){
  
  error(my_logger, "Queried date range is empty.")
  pipeline_message <- unname(stat_codes)[3]
  beepr::beep(sound = 10)
  # session$reload()

}

# # logging parallel output -------------------------------------------------
# n_urls <- length(all_urls)
# n_results <- length(request_results)
# # warn if there is a difference in number of urls and responses
# if(n_urls != n_results){
#   warn(my_logger, "Length of request results and length of urls are not equal.")
#   warn(my_logger, paste("Number of urls to query:", n_urls))
#   warn(my_logger, paste("Number of responses:", n_results))
# }


# api req duration --------------------------------------------------------

log4r::info(my_logger,
     paste("Duration of report request: ", capture.output(Sys.time() - report_start)))

# # tally the status codes returned and log them
# log4r::info(my_logger, "HTTP status code counts as follows:")
# log4r::info(my_logger,
#      capture.output(table(unlist(list.select(request_results, status_code)))))


# 
# # warn if empty content ---------------------------------------------------
# if(all(unlist(list.select(request_results, status_code)) == 204)){
#   error(my_logger, "Queried date range is empty.")
#   pipeline_message <- unname(stat_codes)[3]
#   # output a warning sound
#   beepr::beep(sound = 10)
# }
# 

# remove 204s and errors --------------------------------------------------
# filter out any requests that returned a 204 status with missing content
# print out a text file with their IDs to output_data/missing_site_IDs.txt
# if(pipeline_message != stat_codes[3]){
#   request_results <- handle_missing(request_results)
# }


# tidy up -----------------------------------------------------------------

rm(list = c(
  # "all_urls", 
  # "n_urls", 
  # "n_results", 
  # "cl", 
  # "ncores", 
  "report_start",
  "all_urls_nested_list",
  "all_urls_nested_list_n"
            ))


# cluster report ----------------------------------------------------------
# check environment for presence of cl, indicating shutdown was not successful
# if("cl" %in% ls()){
#   # log issue
#   warn(my_logger, "Cluster persisted following stopCluster() call")
#   # pause execution for 10s
#   Sys.sleep(10)
#   # retry the stop
#   stopCluster(cl)
#   # remove the cluster
#   rm(cl)
# }

# memory report -----------------------------------------------------------

memory_report()