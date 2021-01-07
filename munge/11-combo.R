"
Purpose of script:
Stack listed data into combo data table.
"
log4r::info(my_logger, paste0("############# ", "Start of ", current_file(), " #############"))

if(pipeline_message != "Queried dates are empty."){
  combo <- list.stack(report_data, data.table = TRUE)
}


# dataframe metrics -------------------------------------------------------

# log dataframe metrics
if(pipeline_message != "Queried dates are empty."){
  handle_df(combo)
# tidy up -----------------------------------------------------------------
  rm(report_data)
}

# memory_report -----------------------------------------------------------

memory_report()
