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
log4r::info(my_logger, print(round(elapsed, digits = 3)))


log4r::info(my_logger, paste0("#############End of pipeline#############"))


# sound alert when script completes
beepr::beep("coin")
