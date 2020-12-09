"
Purpose of script:
Prepare the chunks for batch querying of 30 daile site Id reports at a time
"
#calculate the number of chunks required
n_chunks <- round(length(all_sites) / 30, digits = 0)


# create the chunks
id_chunks <- chunk2(all_sites, n_chunks)

# count the number of assigned chunks
n_actual <- length(id_chunks)


# log details
info(my_logger, "########Site Id Chunking##########")


# control flow to print warning if number of chunks calculated differs from
# number of chunks created
if(n_chunks != n_actual) {
  warn(my_logger,
       paste0("Chunks calculated and chunks assigned are not of equal value"))
  warn(my_logger, paste0("Number of chunks calculated: ", n_chunks))
  warn(my_logger, paste0("Number of chunks created: ", n_actual))
  log4r::error(my_logger, "Execution halted")
  stop("Execution halted")
}

info(my_logger, paste0("Number of chunks calculated: ", n_chunks))
info(my_logger, paste0("Number of chunks created: ", n_actual))



# any chunks over 30? -----------------------------------------------------

# get the lengths of all chunks
ch_id_counts <- lapply(id_chunks, length)

if(any(ch_id_counts > 30)){
  cond <- lapply(ch_id_counts, function(x) length(x) > 30)
  
  warn(my_logger, paste0("Listed chunks exceeding 30 site Ids: ", ch_id_counts[unlist(cond)]))
  rm(cond)
  log4r::error(my_logger, "Execution halted")
  stop("Execution halted")
}



# tidy up -----------------------------------------------------------------

rm(list = c(
  "all_sites",
  "n_chunks",
  "n_actual",
  "ch_id_counts"
            ))




# memory report -----------------------------------------------------------
memory_report()

# wrap up script ----------------------------------------------------------
wrap_up()






