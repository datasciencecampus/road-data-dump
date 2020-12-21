"
Purpose of script:
Contain custom functions for use in munge processing scripts
"

# helper functions --------------------------------------------------------

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

# wrap_up -----------------------------------------------------------------

wrap_up <- function() {

  # calculate elapsed time
  elapsed <- Sys.time() - start_time
  # # add to logfile
  info(my_logger, "Script executed. Duration: ")
  info(my_logger, capture.output(round(elapsed, digits = 3)))

  # write all lines to logs/logfile
  readLines(my_logfile)

  # sound alert when script completes
  beepr::beep("coin")

  # Manually stop execution while working on api request
  stop(TRUE)
}



# End of wrap_up -----------------------------------------------------------------


# memory_report -----------------------------------------------------------

memory_report <- function() {

  # perform a manual garbage collection
  gc()
  # get the path of this rscript
  path <- this.path()
  # split out the path directories by backslash
  x <- str_split(path, pattern = "\\\\")
  # show me the filename only
  thisfile <- tail(unlist(x, use.names = FALSE), n = 1)

  # log the used memory at this point
  info(
    my_logger,
    print(paste(
      "Memory size following",
      thisfile, "is", memory.size()
    ))
  )
}


# End of memory_report -----------------------------------------------------------


# 04-GET_sitetypes.R handle_query ------------------------------------------------------------


handle_query <- function(GET_result, resource, site) {
  if (http_error(GET_result)) {
    log4r::info(my_logger, paste("###########GET", resource, "for Site", site, "###########"))
    log4r::info(my_logger, paste("Site", site, "queried url:", GET_result$url))
    log4r::info(my_logger, paste("Date of query:", GET_result$date))
    log4r::info(my_logger, paste("Query durations", capture.output(GET_result$times)))
    info(my_logger, paste("Query status message:", http_status(GET_result)))
    log4r::warn(my_logger, "The GET() request failed")
    log4r::warn(my_logger, paste("HTTP Status code:", GET_result$status_code))
  } else {
    log4r::info(my_logger, paste("###########GET", resource, "for Site", site, "###########"))
    log4r::info(my_logger, paste("###########", resource, "successfully queried for Site", site, "###########"))
    log4r::info(my_logger, paste("Site", site, "queried url:", GET_result$url))
    log4r::info(my_logger, paste("Date of query:", GET_result$date))
    log4r::info(my_logger, paste("Query durations", capture.output(GET_result$times)))
    log4r::info(my_logger, paste("HTTP status code:", GET_result$status_code))
    #
    df_output <- data.frame(
      fromJSON(
        rawToChar(
          GET_result$content
        ), # parse JSON as text
        flatten = TRUE
      ) # coerce to list
    ) # coerce to dataframe
  }
  return(df_output)
}


# End of handle_query ------------------------------------------------------------



# handle_df ---------------------------------------------------------------


handle_df <- function(df_name) {
  info(my_logger, paste0("###### DF insight for ", substitute(df_name), "######"))
  info(my_logger, paste0("Number of rows: ", nrow(df_name)))
  info(my_logger, paste0("Number of columns: ", ncol(df_name)))
  info(my_logger, paste0("Names of columns: ", names(df_name)))
  info(my_logger, paste0(
    "Count of NAs in all columns: ",
    capture.output(
      sapply(df_name, function(x) sum(is.na(x)))
    )
  ))
  info(my_logger, paste0(
    "Data types in all columns: ",
    capture.output(sapply(df_name, class))
  ))
}
# End of handle_df ---------------------------------------------------------------


# end of 04-GET_sitetypes.R handle_query ------------------------------------------------------------



# 07-Get_daily_reports.R  handle_missing ----------------------------------


handle_missing <- function(GET_results) {

  # select all queries where status is 204 (no content but no error)
  response_204s <- list.filter(GET_results, status_code == 204)

  # select just the url from these null content responses
  url_204s <- unlist(list.select(response_204s, url))
  

  # catch all errors too
  url_errors <- list.filter(GET_results, status_code >= 400 && status_code <= 599)
  
  # select all urls
  all_urls <- unlist(list.select(GET_results, url))
  number_urls <- length(all_urls)
  
  all_queried_siteIds <- sapply(
    all_urls,
    function(x) str_extract(x, pattern = "(?<=sites=)([0-9]+)(?=&)")
  )
  # write to cache for reporting
  saveRDS(all_queried_siteIds, "cache/all_queried_siteIds.rds")


  # extract just the siteIds, simplify to a vector
  # character match tested on https://regex101.com/ for varying digit sequences
  # pulls id from string, lookbehind (?<=) and look ahead (?=) so that
  # "sites=" and "&" is not included in the match
  # [0-9]+ matches any sequence of numbers with different lengths
  site_Id_204s <- sapply(
    url_204s,
    function(x) str_extract(x, pattern = "(?<=sites=)([0-9]+)(?=&)")
  )
  # write to cache for reporting
  saveRDS(site_Id_204s, "cache/site_Id_204s.rds")
  
  # count the number of 204s
  number_204s <- length(site_Id_204s)

  site_Id_errors <- sapply(
    url_errors,
    function(x) str_extract(x, pattern = "(?<=sites=)([0-9]+)(?=&)")
  )
  # write to cache for reporting if errors are detected
  if(length(site_Id_errors) >= 1) {
  saveRDS(site_Id_errors, "cache/site_Id_errors.rds")
  }
  
  # count the number of errors
  number_errors <- length(site_Id_errors)

  # find urls that are not responsible for 204 statuses or errors
  urls_not204 <- setdiff(all_urls, c(url_204s, url_errors))

  # filter the request results based on the above. Only these will be parsed.
  reqs_not_204 <- list.filter(GET_results, url %in% urls_not204)

  # create filenames --------------------------------------------------------


  # get the numbers from the daterange whether a test run or not
  dates_used <- paste(unlist(str_extract_all(daterange, "[0-9]+")), collapse = "to")
  # write to cache for reporting
  saveRDS(dates_used, "cache/dates_used.rds")
  
  suffix <- paste0(dates_used, ".txt")

  if (test_run == TRUE) {
    write.table(print(paste(
      "Test run: Missing data report ",
      "Number of missing IDs (204s) for test run: ",
      number_204s,
      " Total number of sites queried: ",
      number_urls,
      " Proportion of Site IDs that were missing (204s) for test run: ",
      round(number_204s / number_urls, digits = 2),
      ". Site Ids that returned no content :",
      paste(site_Id_204s, collapse = ","),
      ". Date period queried: ",
      daterange,
      sep = "\n"
    )),
    file = paste0("output_data/test-missing_site_IDs", suffix)
    )
  } else {
    write.table(print(paste(
      "Missing data report ",
      "Number of missing IDs (204s) for this run: ",
      number_204s,
      " Total number of sites queried: ",
      number_urls,
      " Proportion of Site IDs that were missing (204s) for this run: ",
      round(number_204s / number_urls, digits = 2),
      ". Site Ids that returned no content :",
      paste(site_Id_204s, collapse = ","),
      ". Date period queried: ",
      daterange,
      sep = "\n"
    )),
    file = paste0("output_data/missing_site_IDs", suffix)
    )
  }

  # log the site errors if they exist
  if (length(site_Id_errors >= 1)) {
    warn(my_logger, "Removing errors from api request results:")
    warn(my_logger, site_Id_errors)
  }
  return(reqs_not_204)
}

# End of 07-Get_daily_reports.R  handle_missing ----------------------------------


# 08-parse_present_data.R --------------------------------------------------

handle_report <- function(GET_result) {

  # coerce response to list
  listed_JSON <- fromJSON(
    rawToChar(
      unlist(GET_result$content)
    ), # parse JSON as text
    flatten = TRUE
  )

  # use pattern matching to extract the site ID from the queried url
  site_id <- str_extract(GET_result$url, pattern = "(?<=sites=)([0-9]+)(?=&)")
  # write to a new column in the list
  listed_JSON$Rows$site_id <- site_id
  
  

  # need to convert with as.data.frame or data.table once all JSON returned
  return(listed_JSON$Rows)
}

# End of 08-parse_present_data.R --------------------------------------------------

# 11-extract_direction.R --------------------------------------------------

direction <- function(x) {
  # ensure output is lowered
  tolower(
    # extract all pattern matches, handles NAs gracefully
    str_extract(x, "(([A-Za-z]+)bound)|([A-Za-z\\\\-]+wise)")
  )
}

# End of 11-extract_direction.R --------------------------------------------------

# 12-extract_eastnor.R ----------------------------------------------------

# extract easting and northing matrix
easting_northing <- function(x) {
  # find the pattern locations
  m <- regexpr("GPS Ref: [0-9]+;[0-9]+", x, perl = TRUE)
  # find the matches, remove anything other than coord vals, split by ";", extract as a 2 col matrix
  matches <- matrix(unlist(strsplit(sub("^.*: ", "", regmatches(x, m)), ";")), ncol = 2, byrow = T)
  # line to handle negative indices, replacing with NAs
  matches <- matches[ifelse(m > 0, cumsum(ifelse(m > 0, 1, 0)), NA), ]
  # column names for the matrix
  colnames(matches) <- c("easting", "northing")
  matches
}
# End of 12-extract_eastnor.R ----------------------------------------------------

# site_report.Rmd ---------------------------------------------------------
# detect all rds files in cache
my_rds <- function(my_path) {list.files(my_path, pattern = ".rds")}

# assign all objects by their file prefix to the global environment
assign_objects <- function(filesincache) {
  # print object name
  obj_name <- sapply(str_split(filesincache, "\\."), `[[`, 1)
  # print path to file
  filepath <- paste0("../cache/", filesincache)
  # assign object to global environment
  assign(obj_name, readRDS(filepath), envir = .GlobalEnv)
}


# detect all files and assign them to named objects
assign_rds <- function(my_path){
  my_files <- my_rds(my_path)
  for (i in my_files){
    assign_objects(i)
  }
}

# site_report.Rmd ---------------------------------------------------------
