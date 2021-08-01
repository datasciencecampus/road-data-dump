"
Purpose of script:
Reset environment configuration once pipeline has executed
Prepare Shiny environment for re-runs
"
log4r::info(my_logger, paste0("############# ", "Start of ", basename(this.path()), " #############"))

# detach packages causing conflicts ---------------------------------------
"jsonlite causing issue with validate Email message on app reruns within same
session. To avoid this, force unload on app initiation. Note that jsonlite is
still required in app by shinybusy, so implicit attachment on loading shinybusy
anyway."

#detach("package:jsonlite", force = TRUE, unload = TRUE, character.only = TRUE)

# memory report -----------------------------------------------------------
memory_report()

# pipeline_message --------------------------------------------------------
# if pipeline_message is not equal to status code 2 and 3, then update as successfully
# completed. Note that the pipeline inhereits the pipeline_message "Pipeline running"
# from the UI.
if (pipeline_message != stat_codes[2] && pipeline_message != stat_codes[3]){
  pipeline_message <- unname(stat_codes[1])
}

# wrap up -----------------------------------------------------------------

# calculate elapsed time
elapsed <- Sys.time() - start_time
log4r::info(my_logger, capture.output(round(elapsed, digits = 3)))
log4r::info(my_logger, paste0("#############End of pipeline#############"))


# tidy up -----------------------------------------------------------------

rm(list = c(
  "elapsed",
  "my_logger",
  "logger",
  "file_app",
  "my_logfile",
  "stat_codes"
))

# sound alert when script completes
beepr::beep("coin")

# return to app working directory -----------------------------------------

setwd("app/")
