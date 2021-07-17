"
function of script:
Get daily reports for all discovered site Ids
"
log4r::info(my_logger, paste0("############# ", "Start of ", basename(this.path()), " #############"))

# GET daily reports -------------------------------------------------------
log4r::info(my_logger, "Duration of all site ID daily report request")

report_start <- Sys.time()


# Dates Used
dates_used <- paste(unlist(str_extract_all(daterange, "[0-9]+") 
                           %>% as_vector() 
                           %>% as.Date(format="%d%m%Y") 
                           %>% format("%d-%m-%Y")), 
                    collapse = "_to_")

suffix <- paste0(dates_used, ".txt")

# Missing Site IDS
write.table(print(paste("-----------------")),
            file = paste0("output_data/missing_site_IDs_", suffix),
            append = FALSE, row.names = FALSE, col.names = FALSE)


if(file.exists("cache/site_Id_204s.csv")){
    file.remove("cache/site_Id_204s.csv")
}

if(file.exists("cache/all_queried_siteIds.csv")){
    file.remove("cache/all_queried_siteIds.csv")
}

if(file.exists("cache/site_Id_errors.csv")){
    file.remove("cache/site_Id_errors.csv")
  }
  

# Parallel ----------------------------------------------------------------
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

# Error if no data is returned
if (map(all_requests_tables, nrow) 
    %>% as_tibble() 
    %>% sum() == 0){
  
  error(my_logger, "Queried date range is empty.")
  pipeline_message <- unname(stat_codes)[3]
  beepr::beep(sound = 10)

}

# 204
site_204_csv <- read.csv("cache/site_Id_204s.csv")
saveRDS(site_204_csv, "cache/site_Id_204s.rds")

# Errors
site_id_errors_path <- "cache/site_Id_errors.csv"

if(file.exists(site_id_errors_path)){
  site_errors_csv <- read.csv(site_id_errors_path)
  saveRDS(site_errors_csv, "cache/site_Id_errors.rds")
}

# All Site IDS
all_queried_siteids_csv <- read.csv("cache/all_queried_siteIds.csv")
saveRDS(all_queried_siteids_csv, "cache/all_queried_siteIds.rds")

# api req duration --------------------------------------------------------
log4r::info(my_logger,
     paste("Duration of report request: ", capture.output(Sys.time() - report_start)))

# tidy up -----------------------------------------------------------------

rm(list = c(
  # "all_urls", 
  # "n_urls", 
  # "n_results", 
  # "cl", 
  # "ncores", 
  "report_start",
  "all_urls_nested_list",
  "all_urls_nested_list_n",
  "site_204_csv",
  "all_queried_siteids_csv")
  )


# memory report -----------------------------------------------------------
memory_report()