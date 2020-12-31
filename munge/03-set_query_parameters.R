"
Purpose of script, set parameters required for api requests.
Intend to present this within UI.
Will need:
* Email for user agent.
* start date
* end date
"
log4r::info(my_logger, paste0("############# ", "Start of ", current_file(), " #############"))

# Start Date --------------------------------------------------------------

start_date <- "01092020"

# log query parameters set
if (test_run == FALSE) {
  log4r::info(my_logger, paste("Start date set: ", start_date))
}

# End Date ----------------------------------------------------------------

end_date <- "30092020"
# log query parameters set
if (test_run == FALSE) {
  log4r::info(my_logger, paste("End date set: ", end_date))
}

# User agent -------------------------------------------------------------------

user_email <- "richard.leyshon@ons.gov.uk"

agent_message <- "Parallel request of data for use in ONS, datasciencecampus, road-data-dump"

user_details <- paste(user_email, agent_message)

# api Endpoint ------------------------------------------------------------


ENDPOINT <- "http://webtris.highwaysengland.co.uk/api/v1.0"

RESOURCES <- c("/sitetypes", "/quality/daily", "/quality/overall", "/reports/daily")

log4r::info(my_logger, paste0("api endpoint set as: ", ENDPOINT))



# Max rows ----------------------------------------------------------------


MAX_ROWS <- 40000

log4r::info(my_logger, paste0("Maximum rows for each page in api request set to: ", MAX_ROWS))



# pagination --------------------------------------------------------------

page_no <- 1
# Max rows set to 40k, I have set a comparison against rows returned to ensure
# max rows is not exceeded. If so, the pagination will need to be pursued.