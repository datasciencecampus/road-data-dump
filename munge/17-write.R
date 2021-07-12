"Purpose of script:
Write out product of analysis to csv to /output_data/ folder
"
log4r::info(my_logger, paste0("############# ", "Start of ", basename(this.path()), " #############"))

# create filenames --------------------------------------------------------

# get the numbers from the daterange whether a test run or not
dates_used <- paste(unlist(str_extract_all(daterange, "[0-9]+") 
                           %>% as_vector() 
                           %>% as.Date(format="%d%m%Y") 
                           %>% format("%d-%m-%Y")), 
                    collapse = "_to_")

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
  midas_filename <- paste0("./output_data/midas_", suffix)
  tame_filename <- paste0("./output_data/tame_", suffix)
  tmu_filename <- paste0("./output_data/tmu_", suffix)
}

# write to file -----------------------------------------------------------

if (pipeline_message == stat_codes[3]){
  
  error(my_logger, "Queried date range is empty.")
  beepr::beep(sound = 10)
  
} else{
  
  if(file.exists(midas_filename)){
    file.remove(midas_filename)
  }
  
  if(file.exists(tame_filename)){
    file.remove(tame_filename)
  }
  
  if(file.exists(tmu_filename)){
    file.remove(tmu_filename)
  }
  
  midas %>% cmap(., function(chunk) {
    data.table::fwrite(chunk, file.path(midas_filename), append = TRUE)
    gc()
    NULL
  }, lazy = FALSE)
  
  gc()
  
  tame %>% cmap(., function(chunk) {
    data.table::fwrite(chunk, file.path(tame_filename), append = TRUE)
    gc()
    NULL
  }, lazy = FALSE)
  
  gc()
  
  tmu %>% cmap(., function(chunk) {
    data.table::fwrite(chunk, file.path(tmu_filename), append = TRUE)
    gc()
    NULL
  }, lazy = FALSE)
 
  gc() 

}

# testing write status ----------------------------------------------------
# test presence of output files and log

# MIDAS write status
if(file.exists(midas_filename)){
  log4r::info(my_logger, paste(midas_filename, "file written successfully."))
} else{
  warn(my_logger, "MIDAS file not found. Check logs.")
}

# TAME write status
if(file.exists(tame_filename)){
  log4r::info(my_logger, paste(tame_filename, "file written successfully."))} else{
  warn(my_logger, "TAME file not found. Check logs.")
}

# TMU write status
if(file.exists(tmu_filename)){
  log4r::info(my_logger, paste(tmu_filename, "file written successfully."))} else{
  warn(my_logger, "TMU file not found. Check logs.")
}

# tidy up environment -----------------------------------------------------
rm(list = c(
  "midas_filename",
  "tame_filename",
  "tmu_filename",
  "daterange"
))

