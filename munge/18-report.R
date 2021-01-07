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

if(pipeline_message != "Queried dates are empty."){
  # render the site report using the cached variables
  rmarkdown::render("reports/site_report.Rmd",
  output_file = report_name)
}

# tidy up environment -----------------------------------------------------
rm(list = c(

  "dates_used",
  "my_rds",
  "assign_rds",
  "assign_objects"
))

if(pipeline_message != "Queried dates are empty."){
rm(list = c(
  "site_Id_204s",
  "sitetypes",
  "all_queried_siteIds"
  ))
}

# memory report -----------------------------------------------------------
memory_report()