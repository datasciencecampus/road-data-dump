"
Purpose of script:
Knit site report markdown and wrap up pipeline
"
log4r::info(my_logger, paste0("############# ", "Start of ", current_file(), " #############"))

# label test run site reports by filename
if(test_run == TRUE){
  report_name <- "test_site_report.html"
} else{
  # if not testing pipeline, use date parameters in filename
  report_name <- paste0("site_report_", dates_used, ".html")
}


# render the site report using the cached variables
rmarkdown::render("reports/site_report.Rmd",
                  output_file = report_name)

# wrap up -----------------------------------------------------------------

# calculate elapsed time
elapsed <- Sys.time() - start_time
print(round(elapsed, digits = 3))


# write out head of midas -------------------------------------------------
# output head of MIDAS for presentation in UI
saveRDS(head(midas, n = 10), file = "app/data/midas_head.rds")
# log this write
if(file.exists("app/data/midas_head.rds")){
  log4r::info(my_logger, "MIDAS head written to app cache.")
} else {
  warn(my_logger, "MIDAS head not written to app cache. Check logs.")
}


log4r::info(my_logger, paste0("#############End of pipeline#############"))


# sound alert when script completes
beepr::beep("coin")
