"
Purpose of script, set parameters required for api requests.
Intend to present this within UI.
Will need:
* Email for user agent.
* start date
* end date
"


# api Endpoint ------------------------------------------------------------


ENDPOINT <- "http://webtris.highwaysengland.co.uk/api/v1.0"

RESOURCES <- c("/sitetypes", "/quality/daily", "/quality/overall", "/reports/daily")

info(my_logger, paste0("api endpoint set as: ", ENDPOINT))



# Max rows ----------------------------------------------------------------


MAX_ROWS <- 40000

info(my_logger, paste0("Maximum rows for each page in api request set to: ", MAX_ROWS))


# User agent -------------------------------------------------------------------

user_email <- "richard.leyshon@ons.gov.uk"

agent_message <- "Requesting sensor data for use in ONS, datasciencecampus, road-data-dump"

user_details <- paste(user_email, agent_message)

# Start Date --------------------------------------------------------------

start_date <- "01012020"



# End Date ----------------------------------------------------------------

end_date <- "02012020"



# date_range --------------------------------------------------------------

daterange <- paste0("&start_date=", start_date, "&end_date=", end_date)
  



