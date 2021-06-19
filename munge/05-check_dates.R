"Purpose of script:
Create daterange query parameter from shiny UI output parameters
"
log4r::info(my_logger, paste0("############# ", "Start of ", basename(this.path()), " #############"))

# create daterange --------------------------------------------------------

# only set parameters for a full run if not testing pipeline
if (test_run == FALSE) {
  
  # date handling -----------------------------------------------------------
  
  s_date <- as.Date.character(start_date, "%d%m%Y")
  e_date <- as.Date.character(end_date, "%d%m%Y")
  
  # find out the date period
  date_diff <- e_date - s_date
  
  # date_range --------------------------------------------------------------
  
  daterange <- paste0("&start_date=", start_date, "&end_date=", end_date)
  
  log4r::info(my_logger, paste("daterange set as:", daterange))
  
  
  
  # tidy up -----------------------------------------------------------------
  rm(list = c("start_date", "end_date", "s_date", "e_date", "date_diff"))
}