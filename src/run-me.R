"Purpose of script:
Autoload files found in /data/ and or /cache/ folders, /cache/ taking precedence by file name.
eg ./cache/combo.Rdata takes loading precedence over ./data/combo.csv
Load packages, execute sequential scripts found in /munge/ folder

To adjust project configuration, edit the values in ./config/global.dcf
"

library('ProjectTemplate')
load.project()
