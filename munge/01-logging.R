"
Purpose of script:
1.Initiate logging dependencies.
2. Source custom functions form func/ directory
"
# initiate logging --------------------------------------------------------


# File Logger
# log_file <- "logs/logfile.txt"
# file_logger <- logger("INFO", appenders = file_appender(log_file))

#>     debug

my_logfile <- "logs/logfile.txt"

my_console_appender <- console_appender(layout = default_log_layout())

my_file_appender <-  file_appender(my_logfile, append = TRUE, 
                                 layout = default_log_layout())

my_logger <- log4r::logger(threshold = "INFO", 
                           appenders = list(my_console_appender,
                                            my_file_appender))



# api logging -------------------------------------------------------------

api_logfile <- "logs/api_requests.txt"

api_console_appender <- console_appender(layout = default_log_layout())

api_file_appender <-  file_appender(api_logfile, append = TRUE, 
                                   layout = default_log_layout())

api_logger <- log4r::logger(threshold = "INFO", 
                           appenders = list(api_console_appender,
                                            api_file_appender))


# new log entry -----------------------------------------------------------

info(my_logger, message = "###################New Run#########################")


# log environment status --------------------------------------------------

# capture session info
info(my_logger, capture.output(sessionInfo()))


# source func/functions.R -------------------------------------------------

# import custom functions
source("func/functions.r")