"
Purpose of script:
Get site by type.
Returns the following for Midas, Tame and TMU:

"


# site.midas --------------------------------------------------------------



# site.tame ---------------------------------------------------------------
TAME_qstring <- paste0(ENDPOINT, RESOURCES[1], "/2/sites")

request_result <- GET(url = TAME_qstring,
                      user_agent(user_details)
)

# log errors / status codes and coerce to df if request was successful
site.tame <- handle_query(request_result, RESOURCES[1], site = "TAME")



# site.tmu ----------------------------------------------------------------

TMU_qstring <- paste0(ENDPOINT, RESOURCES[1], "/3/sites")

request_result <- GET(url = TMU_qstring,
                      user_agent(user_details)
)

# log errors / status codes and coerce to df if request was successful
site.tmu <- handle_query(request_result, RESOURCES[1], site = "TMU")



# wrap up script ----------------------------------------------------------

wrap_up()

# Manually stop execution while working on api request
stop(TRUE)



