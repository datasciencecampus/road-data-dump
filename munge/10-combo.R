"
Purpose of script:
Stack listed data into combo data table.
"
info(my_logger, paste0("############# ", "Start of ", current_file(), " #############"))


combo <- list.stack(report_data, data.table = TRUE)


# dataframe metrics -------------------------------------------------------

# log dataframe metrics
handle_df(combo)



# tidy up -----------------------------------------------------------------
rm(report_data)

# memory_report -----------------------------------------------------------

memory_report()
