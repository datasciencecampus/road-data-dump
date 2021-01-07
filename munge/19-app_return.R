"
Purpose of script:
Reset environment configuration once pipeline has executed
Prepare Shiny environment for re-runs

"
log4r::info(my_logger, paste0("############# ", "Start of ", current_file(), " #############"))

# return table heads ------------------------------------------------------
"Provide a preview of data for the UI"
if("midas" %in% ls()){
  midas <- head(midas, n = 100)
}
if("tame" %in% ls()){
  tame <- head(tame, n = 100)
}
if("tmu" %in% ls()){
  tmu <- head(tmu, n = 100)
}

# detach packages causing conflicts ---------------------------------------
"jsonlite causing issue with validate Email message on app reruns within same
session. To avoid this, force unload on app initiation. Note that jsonlite is
still required in app by shinybusy, so implicit attachment on loading shinybusy
anyway."

detach("package:jsonlite", force = TRUE, unload = TRUE, character.only = TRUE)



# memory report -----------------------------------------------------------
memory_report()

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
  "current_file",
  "my_console_appender",
  "my_file_appender",
  "my_logfile",
  "memory_report"
))

# sound alert when script completes
beepr::beep("coin")


# return to app working directory -----------------------------------------

setwd("app/")