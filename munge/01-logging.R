"
Purpose of script:
1.Initiate logging dependencies.
2. Source custom functions form func/ directory
"

# update pipeline message -------------------------------------------------

pipeline_message <- "Pipeline running."

# initiate logging --------------------------------------------------------

my_logfile <- "logs/logfile.txt"

my_console_appender <- console_appender(layout = default_log_layout())

my_file_appender <- file_appender(my_logfile,
  append = TRUE,
  layout = default_log_layout()
)

my_logger <- log4r::logger(
  threshold = "INFO",
  appenders = list(
    my_console_appender,
    my_file_appender
  )
)



# new log entry -----------------------------------------------------------

log4r::info(my_logger, message = "###################New Run#########################")

# log pre-existing env objects in event of re-running pipeline
log4r::info(my_logger, paste("Environment objects found on initiation:",
                             paste(ls(), collapse = ", ")))


# source func/functions.R -------------------------------------------------
# import custom functions
source("func/functions.r")

log4r::info(my_logger, paste0("############# ", "Start of ", current_file(), " #############"))

if(test_run == TRUE){
  log4r::info(my_logger, "Not testing pipeline.")
} else if(test_run == TRUE) {
  log4r::info(my_logger, "Testing pipeline.")
  
}

system_deets <- Sys.info()

log4r::info(my_logger, paste("Operating System:", system_deets[[1]]))

os_version <- system_deets[[5]]

log4r::info(my_logger, paste("OS version:", os_version))

# if not running on 64bit R, output a warning to console.
if (os_version != "x86-64"){
  warn(my_logger, "Check that R is 64 bit not 32, possible memory limitations")
}

log4r::info(my_logger, paste("Effective Username:", system_deets[[8]]))


# log environment status --------------------------------------------------

# capture session info
log4r::info(my_logger, capture.output(sessionInfo()))


# tidy up -----------------------------------------------------------------

rm(list = c("system_deets", "os_version"))

# remove outputs if available ---------------------------------------------
# if rerunning pipeline within same session, can run into memory management issues.
# remove output dataframes if still detected in environment.

if("midas" %in% ls()){
  rm(midas)
  log4r::info(my_logger, "Rerunning pipeline, removing midas table")
}
if("tame" %in% ls()){
  rm(tame)
  log4r::info(my_logger, "Rerunning pipeline, removing tame table")
}
if("tmu" %in% ls()){
  rm(tmu)
  log4r::info(my_logger, "Rerunning pipeline, removing tmu table")
}

# memory report -----------------------------------------------------------

memory_report()