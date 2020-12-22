"
Purpose of script:
Knit site report markdown and wrap up pipeline
"
# render the site report using the cached variables
rmarkdown::render("reports/site_report.Rmd",
                  output_file = paste0("site_report_", dates_used, ".html"))

# wrap up -----------------------------------------------------------------

# calculate elapsed time
elapsed <- Sys.time() - start_time
print(round(elapsed, digits = 3))


info(my_logger, paste0("#############End of pipeline#############"))


# sound alert when script completes
beepr::beep("coin")
