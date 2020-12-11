'
function of script:
Coerce present data to dataframe and append
'

#and continue to process only the 200s
# stored in present_requests

# log errors / status codes and coerce to df if request was successful

combo <- handle_report(request_result, resource = RESOURCES[4], site = siteId)



# log dataframe metrics
handle_df(combo)



# tidy up -----------------------------------------------------------------

# rm(request_result)


# memory report -----------------------------------------------------------

memory_report()