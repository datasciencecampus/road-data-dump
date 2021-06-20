"
Purpose of script:
1.Initiate logging dependencies.
2. Source custom functions from func/ directory
"

# calculate start time for performance
start_time <- Sys.time()

# update pipeline message -------------------------------------------------

pipeline_message <- "Pipeline running."

# initiate logging --------------------------------------------------------
# try creating the logfile if deleted

try(
  log_file_ops(dir_path = "logs")
  )

my_logfile <- "logs/logfile.txt"



log_enable(logfile_loc = my_logfile, logger_nm = my_logger)


# new log entry -----------------------------------------------------------

log4r::info(my_logger, message = "###################New Run#########################")
log4r::info(my_logger, paste0("############# ", "Start of ", basename(this.path()), " #############"))

# log pre-existing env objects in event of re-running pipeline
log4r::info(my_logger, paste("Environment objects found on initiation:",
                             paste(ls(), collapse = ", ")))


# source func/functions.R -------------------------------------------------
# import table functions
source("func/tables.R")
# import pipeline functions
source("func/queries.R")


if(test_run == FALSE){
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
  log4r::error(my_logger, "Check that R is 64 bit not 32 due to memory limitations")
  stop("64 bit R required to run pipeline.")
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