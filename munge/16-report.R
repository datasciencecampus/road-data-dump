"
Purpose of script:
Knit site report markdown and wrap up pipeline
"



# wrap up -----------------------------------------------------------------

# calculate elapsed time
elapsed <- Sys.time() - start_time
print(round(elapsed, digits = 3))


info(my_logger, paste0("#############End of pipeline#############"))


# sound alert when script completes
beepr::beep("coin")
