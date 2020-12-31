"Purpose of script:
Loads custom functions from func/functions.R
Execute sequential scripts found in /munge/ folder

To adjust project configuration, edit the values in ./config/global.dcf
"
# setwd as expected project wd, different to shiny runtime
setwd(stringr::str_remove(this.path::this.dir(), "/src"))

# read test status from cache, output by UI
test_run <- as.logical(readRDS("cache/test_run.rds"))

library('ProjectTemplate')
load.project()
