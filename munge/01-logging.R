"
Purpose of script:
1.Initiate logging dependencies.
2. Source custom functions form func/ directory
"
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

info(my_logger, message = "###################New Run#########################")
info(my_logger, paste0("############# ", "Start of ", current_file(), " #############"))

system_deets <- Sys.info()

info(my_logger, paste("Operating System:", system_deets[[1]]))

os_version <- system_deets[[5]]

info(my_logger, paste("OS version:", os_version))

# if not running on 64bit R, output a warning to console.
if (os_version != "x86-64"){
  warn(my_logger, "Check that R is 64 bit not 32, possible memory limitations")
}

info(my_logger, paste("Effective Username:", system_deets[[8]]))


# log environment status --------------------------------------------------

# capture session info
info(my_logger, capture.output(sessionInfo()))


# source func/functions.R -------------------------------------------------

# import custom functions
source("func/functions.r")

# tidy up -----------------------------------------------------------------

rm(list = c("system_deets", "os_version"))
