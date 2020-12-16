"Purpose of script:
Loads custom functions from func/functions.R
Execute sequential scripts found in /munge/ folder


To adjust project configuration, edit the values in ./config/global.dcf
"
# Assign as TRUE for first run, script will query one site and one day. If it worked, you should hear
# a bleep. You can then set to FALSE for future runs. If it didn't work, check logs and Email
# richard.leyshon@ons.gov.uk
test_run <- FALSE

library('ProjectTemplate')
load.project()
