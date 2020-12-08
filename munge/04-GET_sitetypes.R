'
Purpose of script:
Get site by type.
Returns the following for Midas, Tame and TMU:
[1] "row_count"         "sites.Id"          "sites.Name"       
[4] "sites.Description" "sites.Longitude"   "sites.Latitude"   
[7] "sites.Status"
Output of this script is the equivalent of the site.tame, site.midas & 
site.tmu csvs.
'


# site.midas --------------------------------------------------------------
MIDAS_qstring <- paste0(ENDPOINT, RESOURCES[1], "/1/sites")

request_result <- GET(url = MIDAS_qstring,
                      user_agent(user_details)
)

# log errors / status codes and coerce to df if request was successful
site.midas <- handle_query(request_result, RESOURCES[1], site = "MIDAS")

# log dataframe metrics
handle_df(site.midas)

# site.tame ---------------------------------------------------------------
TAME_qstring <- paste0(ENDPOINT, RESOURCES[1], "/2/sites")

request_result <- GET(url = TAME_qstring,
                      user_agent(user_details)
)

# log errors / status codes and coerce to df if request was successful
site.tame <- handle_query(request_result, RESOURCES[1], site = "TAME")

# log dataframe metrics
handle_df(site.tame)


# site.tmu ----------------------------------------------------------------

TMU_qstring <- paste0(ENDPOINT, RESOURCES[1], "/3/sites")

request_result <- GET(url = TMU_qstring,
                      user_agent(user_details)
)

# log errors / status codes and coerce to df if request was successful
site.tmu <- handle_query(request_result, RESOURCES[1], site = "TMU")

# log dataframe metrics
handle_df(site.tmu)



# wrap up script ----------------------------------------------------------

wrap_up()

# Manually stop execution while working on api request
stop(TRUE)



