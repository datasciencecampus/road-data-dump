"Purpose of script:
Write out product of analysis to csv to /output_data/ folder
"
info(my_logger, paste0("#############", "Start of", this.path(), "#############"))

# create filenames --------------------------------------------------------

# get the numbers from the daterange whether a test run or not
dates_used <- paste(unlist(str_extract_all(daterange, "[0-9]+")), collapse = "to")
suffix <- paste0(dates_used, ".csv")

# write to file -----------------------------------------------------------
# if testing then prepend files with "test-run"

if (test_run == TRUE){
  # write out csvs
  fwrite(midas, paste0("output_data/test-midas", suffix), row.names=F, quote=F)
  fwrite(tame, paste0("output_data/test-tame", suffix), row.names=F, quote=F)
  fwrite(tmu, paste0("output_data/test-tmu", suffix), row.names=F, quote=F)
} else {
# if not testing, append filename with daterange
# write out csvs
fwrite(midas, paste0("output_data/midas", suffix), row.names=F, quote=F)
fwrite(tame, paste0("output_data/tame", suffix), row.names=F, quote=F)
fwrite(tmu, paste0("output_data/tmu", suffix), row.names=F, quote=F)

}

# wrap up -----------------------------------------------------------------

# calculate elapsed time
elapsed <- Sys.time() - start_time
print(round(elapsed, digits = 3))


info(my_logger, paste0("#############End of pipeline#############"))


# sound alert when script completes
beepr::beep("coin")

