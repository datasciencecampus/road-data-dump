Here you can store any preprocessing or data munging code for your project. For example, if you need to add columns at runtime, merge normalized data sets or globally censor any data points, that code should be stored in the `munge` directory. The preprocessing scripts stored in `munge` will be executed sequentially when you call `load.project()`, so you should append numbers to the filenames to indicate their sequential order.

# Guide to munge environment variables
Created at:


Removed at:
01
rm(list = c("system_deets", "os_version"))
04
if (test_run == FALSE) {
  rm(list = c("start_date", "end_date", "s_date", "e_date", "date_diff"))
}
05
rm(list = c(
  "request_result",
  "MIDAS_qstring",
  "TAME_qstring",
  "TMU_qstring",
  "user_email"
))
07
rm(all_sites)

08
  "all_urls", 
  "n_urls", 
  "n_results", 
  "cl", 
  "ncores", 
  "report_start"
09
   if("retry_urls" %in% ls()) {
    "retry_urls",
    "retried_results"}
if("retry_urls2" %in% ls()){
  rm(list = c(
    "retry_urls2",
    "retried_results",
    "caught_retries2"
    ))
}
if("retry_urls3" %in% ls()){
  rm(list = c(
    "retry_urls4",
    "retried_results",
    "caught_retries3"))
}


    "slow_retry", - func
    "slower_retry", - func
    "slowest_retry" - func

10
  "request_results",
  "handle_report", - func
  "agent_message",
  "end_date",
  "ENDPOINT",
  "MAX_ROWS",
  "RESOURCES",
  "start_date",
  "user_details"
11
rm(report_data)
12
rm(list = c(
  "site_midas",
  "site_tame",
  "site_tmu",
  "sitetypes",
  "site_cols",
  "sites_cols",
  "site_unexp",
  "sites_unexp",
  "expected_cols"
))
13
rm(direction) - func
14
rm(easting_northing) - func
15
 if(length(null_matches) > 0){
rm(nullmatch_combo)
}

  "sites",
  "null_matches"
16
rm(combo)

17
  "midas_filename",
  "tame_filename",
  "tmu_filename",
  "daterange"

18
within site_report.rmd
rm(list = c(
  "slow_retry",
  "slower_retry",
  "slowest_retry",
  "direction",
  "easting_northing",
  "handle_df",
  "handle_errors",
  "handle_missing",
  "handle_query",
  "handle_report",
  "wrap_up",
  "adj_file_nos"
))


within pipeline:
rm(list = c(
  "site_Id_204s",
  "sitetypes",
  "dates_used",
  "my_rds",
  "assign_rds",
  "assign_objects",
  "all_queried_siteIds"
))

19
  "elapsed",
  "my_logger",
  "logger",
  "current_file" - func,
  "my_console_appender",
  "my_file_appender",
  "my_logfile",
  "memory_report"
