"
Purpose of script:
1.Initiate logging dependencies.
2. Source custom functions form func/ directory

"


# initiate logging --------------------------------------------------------


# File Logger
log_file <- "logs/logfile"
file_logger <- logger("INFO", appenders = file_appender(log_file))

# source func/functions.R -------------------------------------------------

# import custom functions
source("func/functions.r")