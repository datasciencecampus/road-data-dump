'
function of script:
Get daily reports for all discovered site Ids
'
# test sample query string



request_result <- GET(url = "http://webtris.highwaysengland.co.uk/api/v1.0/reports/daily?sites=1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30&start_date=01012020&end_date=02012020&page=1&page_size=40000",
                      user_agent(user_details)
)

# log errors / status codes and coerce to df if request was successful

combo <- handle_report(request_result, resource = RESOURCES[4])


# log dataframe metrics
handle_df(combo)



# tidy up -----------------------------------------------------------------

rm(request_result)



# memory report -----------------------------------------------------------

memory_report()


# wrap up -----------------------------------------------------------------

wrap_up()
