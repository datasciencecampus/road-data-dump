"Purpose of script:
Split files processed in prep.R by site
"
info(my_logger, paste0("############# ", "Start of ", current_file(), " #############"))

# split into midas,tame,tmu

midas <- combo[combo$type == "midas", ]
tame <- combo[combo$type == "tame", ]
tmu <- combo[combo$type == "tmu", ]


# tidy up -----------------------------------------------------------------

rm(combo)


# memory_report -----------------------------------------------------------

memory_report()
