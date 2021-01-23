"Project Template helper functions"

# helper functions --------------------------------------------------------

# current_file ------------------------------------------------------------
current_file <- function(){
  # get last element of this.path()
  sapply(str_split(this.path(), pattern = "\\\\"), tail, 1)
}
# End of current_file ------------------------------------------------------------


# adj_file_nos ------------------------------------------------------------

"This function is used to increment / decrease sequential scripts within the munge
directory, to make for simple adjustment of additional files. It takes 3 arguments:

directory. The directory to read from and write to. By default set to the munge directory.

target. The number in the sequential scripts to begin the adjustment. The adjustment will
affect script with that leading digit and greater.

action. By default set to 'up', will increase all scripts greater than or equal to target by 1.
'down' will decrease the same files by 1.

"

adj_file_nos <- function(target, directory = "munge", action = "up") {
  x <- list.files(directory)
  
  # filter out anything that doesn't contain digits at start of string
  y <- x[grepl("^[0-9]", x)]
  
  # extract numbering
  z <- as.numeric(stringr::str_extract(y, "^[0-9]{2}"))
  
  # remove all numbers from listed filenames vector
  y_new <- stringr::str_remove(y, "^[0-9]{2}")
  
  # test lengths are equal
  if (length(y) != length(z)) {
    stop(
      paste(
        "Execution halted: Number of files does not equal number of extracted digits",
        paste("Length of filenames:", length(y), paste(y, collapse = ", ")),
        paste("Length of extracted digits:", length(z), paste(z, collapse = ", "))
      )
    )
  }
  
  # if action == up (the default), increment numbers from target and larger up by one
  if (action == "up") {
    z_new <- z
    z_new[z_new >= target] <- z_new[z_new >= target] + 1
    print(paste(length(z_new[z_new >= target]), "file(s) incremented"))
    
    # if action == down, decrease numbers from target and larger down by one
  } else if (action == "down") {
    z_new <- z
    z_new[z_new >= target] <- z_new[z_new >= target] - 1
    print(paste(length(z_new[z_new >= target]), "file(s) decreased"))
  }
  
  # convert to character
  format(z_new)
  # wherever the digits are single, add a 0 in front
  z_new[stringr::str_count(z_new) == 1] <- paste0(
    "0", z_new[stringr::str_count(z_new) == 1]
  )
  print(paste("Digits assigned: ", paste(z_new, collapse = ", ")))
  
  # paste together new digits and filenames
  adj_filenames <- paste0(z_new, y_new)
  
  # paste directory name to complete write path
  old_filenames <- paste(directory, y[y != adj_filenames], sep = "/")
  adj_filenames <- paste(directory, adj_filenames[adj_filenames != y], sep = "/")
  
  # test lengths are equal
  if (length(old_filenames) != length(adj_filenames)) {
    stop(
      paste(
        "Execution halted: Number of old filenames does not equal number of new filenames",
        paste(
          "Length of old filenames:", length(old_filenames), paste(
            old_filenames,
            collapse = ", "
          )
        ),
        paste("Length of adjusted filenames:", length(adj_filenames), paste(
          adj_filenames,
          collapse = ", "
        ))
      )
    )
  }
  
  # write out only adjusted filenames
  file.rename(from = old_filenames, to = adj_filenames)
  print(paste(
    length(old_filenames), "Filenames adjusted from: ",
    paste(old_filenames, collapse = ", "),
    "to",
    paste(adj_filenames, collapse = ", ")
  ))
}
# End of adj_file_nos ------------------------------------------------------------

# memory_report -----------------------------------------------------------

memory_report <- function() {
  # show me the filename of current file
  thisfile <- current_file()
  
  # log the used memory at this point
  log4r::info(
    my_logger,
    print(paste(
      "Memory size following",
      thisfile, "is", memory.size()
    ))
  )
  # perform a manual garbage collection
  gc()
}
# End of memory_report -----------------------------------------------------------


# wrap_up -----------------------------------------------------------------

wrap_up <- function(pipeline_message) {
  # calculate elapsed time
  elapsed <- Sys.time() - start_time
  # # add to logfile
  log4r::info(my_logger, "Script executed. Duration: ")
  log4r::info(my_logger, capture.output(round(elapsed, digits = 3)))
  
  # write all lines to logs/logfile
  readLines(my_logfile)
  
  # update pipeline message. '<<-' searches for `pipeline_message` in parent env
  pipeline_message <<- "Pipeline halted."
  
  # sound alert when script completes
  beepr::beep("coin")
  
  # Manually stop execution while working on api request
  stop(paste("wrap up at", current_file()))
  
}
# End of wrap_up -----------------------------------------------------------------