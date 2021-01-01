"Purpose of script:
Write out product of analysis to csv to /output_data/ folder
"
log4r::info(my_logger, paste0("############# ", "Start of ", current_file(), " #############"))

# create filenames --------------------------------------------------------

# get the numbers from the daterange whether a test run or not
dates_used <- paste(unlist(str_extract_all(daterange, "[0-9]+")), collapse = "to")
suffix <- paste0(dates_used, ".csv")


# create filenames --------------------------------------------------------

# if testing then prepend files with "test-run"

if (test_run == TRUE){
  # label files with 'test'
  midas_filename <- paste0("output_data/test-midas", suffix)
  tame_filename <- paste0("output_data/test-tame", suffix)
  tmu_filename <- paste0("output_data/test-tmu", suffix)
} else {
  # if not testing, paste daterange to filename
  midas_filename <- paste0("output_data/midas", suffix)
  tame_filename <- paste0("output_data/tame", suffix)
  tmu_filename <- paste0("output_data/tmu", suffix)
}

# write to file -----------------------------------------------------------

# write out csvs
fwrite(midas, midas_filename, row.names = F, quote = F)
fwrite(tame, tame_filename, row.names = F, quote = F)
fwrite(tmu, tmu_filename, row.names = F, quote = F)



# testing write status ----------------------------------------------------
# test presence of output files and log

# MIDAS write status
if(file.exists(midas_filename)){
  log4r::info(my_logger, "MIDAS file written.")
  # output head of MIDAS for presentation in UI
  saveRDS(head(midas, n = 10), file = "cache/midas_head.rds")
  # log this write
  if(file.exists("cache/midas_head.rds")){
  log4r::info(my_logger, "MIDAS head written to cache.")
  } else {
    warn(my_logger, "MIDAS head not written to cache. Check logs.")
  }
} else{
  warn(my_logger, "MIDAS file not found. Check logs.")
}

# TAME write status
if(file.exists(tame_filename)){
  log4r::info(my_logger, "TAME file written.")
} else{
  warn(my_logger, "TAME file not found. Check logs.")
}

# TMU write status
if(file.exists(tmu_filename)){
  log4r::info(my_logger, "TMU file written.")
} else{
  warn(my_logger, "TMU file not found. Check logs.")
}