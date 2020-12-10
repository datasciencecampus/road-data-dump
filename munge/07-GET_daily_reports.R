'
function of script:
Get daily reports for all discovered site Ids
'
# test sample query string



request_result <- GET(url = current_query,
                      user_agent(user_details)
)


# log errors / status codes and coerce to df if request was successful

combo <- handle_report(request_result, resource = RESOURCES[4], site = siteId)


# log dataframe metrics
handle_df(combo)



# tidy up -----------------------------------------------------------------

rm(request_result)



# memory report -----------------------------------------------------------

memory_report()