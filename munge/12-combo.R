"
Purpose of script:
Stack listed data into combo data table.
"
log4r::info(my_logger, paste0("############# ", "Start of ", current_file(), " #############"))

if(pipeline_message != stat_codes[3]){
  combo <- list.stack(report_data, data.table = TRUE)

# dataframe metrics -------------------------------------------------------
  handle_df(combo)
# tidy up -----------------------------------------------------------------
  rm(report_data)
  
}

# memory_report -----------------------------------------------------------

memory_report()