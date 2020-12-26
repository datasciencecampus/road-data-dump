"Purpose of script:
Check input dates and break early if:
* more than 31 days
* end date is earlier than start date
* not a viable date.
"
info(my_logger, paste0("############# ", "Start of ", current_file(), " #############"))

# create daterange --------------------------------------------------------

# only set parameters for a full run if not testing pipeline
if (test_run == FALSE) {
  
  # date handling -----------------------------------------------------------
  
  s_date <- as.Date.character(start_date, "%d%m%Y")
  e_date <- as.Date.character(end_date, "%d%m%Y")
  
  # incorrect dates such as 32092020 result in NAs that propogate forwards
  # catch these here and break
  if(is.na(s_date) | is.na(e_date)){
    error(my_logger, "Execution halted, NAs found in start or end date. Please
        adjust start_date and end_date in munge/03-set_query_parameters.R")
    stop("Invalid date set.")
  }
  
  # find out the date period
  date_diff <- e_date - s_date
  
  # halt execution if not testing and date range requested is larger than one calendar month
  if(date_diff > 31) {
    error(my_logger, "Execution halted, date period requested exceeds 31 days. Please
        adjust start_date and end_date in munge/03-set_query_parameters.R")
    stop("Date limit exceeded 31 days")
  } else if(date_diff < 0) {
    error(my_logger, "Execution halted, end date is before start date. Please
        adjust start_date and end_date in munge/03-set_query_parameters.R")
    stop("End date is before start date.")
  }
  
  # date_range --------------------------------------------------------------
  
  daterange <- paste0("&start_date=", start_date, "&end_date=", end_date)
  
  info(my_logger, paste("daterange set as:", daterange))
  
  
  
  # tidy up -----------------------------------------------------------------
  rm(list = c("start_date", "end_date", "s_date", "e_date", "date_diff"))
}