"
Purpose of script:
Get site by type.
Returns the following for Midas, Tame and TMU:

"

TMU_qstring <- paste0(ENDPOINT, RESOURCES[1], "/3/sites")

request_result <- GET(url = TMU_qstring,
                      user_agent(user_details)
)

str(request_result)

# log errors / status codes and parse as text if request was successful
req_content <- handle_query(request_result, RESOURCES[1], site = "TMU")



test <- fromJSON(rawToChar(request_result$content), flatten = TRUE) %>% data.frame()
str(test)
# that gets us to a dataframe, what about a datatable?



# wrap up script ----------------------------------------------------------

wrap_up()

# Manually stop execution while working on api request
stop(TRUE)



