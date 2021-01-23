"hold pipeline functions
all functions processing data tables
"
# handle_df ---------------------------------------------------------------

handle_df <- function(df_name) {
  log4r::info(my_logger, paste0("###### DF insight for ", substitute(df_name), "######"))
  log4r::info(my_logger, paste0("Number of rows: ", nrow(df_name)))
  log4r::info(my_logger, paste0("Number of columns: ", ncol(df_name)))
  log4r::info(my_logger, paste0("Names of columns: ", paste(names(df_name), collapse = ", ")))
  log4r::info(my_logger, paste0(
    "Count of NAs in all columns: ",
    capture.output(
      sapply(df_name, function(x) sum(is.na(x)))
    )
  ))
  log4r::info(my_logger, paste0(
    "Data types in all columns: ",
    capture.output(sapply(df_name, class))
  ))
}
# End of handle_df ---------------------------------------------------------------

# 13-extract_direction.R --------------------------------------------------

direction <- function(x) {
  # ensure output is lowered
  tolower(
    # extract all pattern matches, handles NAs gracefully
    str_extract(x, "(([A-Za-z]+)bound)|([A-Za-z\\\\-]+wise)")
  )
}

# End of 13-extract_direction.R --------------------------------------------------

# 14-extract_eastnor.R ----------------------------------------------------

# old eastnor function ----------------------------------------------------
# # extract easting and northing matrix
# easting_northing <- function(x) {
#   # find the pattern locations
#   m <- regexpr("GPS Ref: [0-9]+;[0-9]+", x, perl = TRUE)
#   # find the matches, remove anything other than coord vals, split by ";", extract as a 2 col matrix
#   matches <- matrix(unlist(strsplit(sub("^.*: ", "", regmatches(x, m)), ";")), ncol = 2, byrow = T)
#   # line to handle negative indices, replacing with NAs
#   matches <- matches[ifelse(m > 0, cumsum(ifelse(m > 0, 1, 0)), NA), ]
#   # column names for the matrix
#   colnames(matches) <- c("easting", "northing")
#   matches
# }

# new eastnor function ----------------------------------------------------

# extract easting and northing matrix
easting_northing <- function(x) {
  
  # extract coord vals, split by ";", extract as a 2 col matrix
  matches <- str_split(str_extract(string = x,
                                   # look behind regex, don't include "GPS Ref: " in result
                                   pattern = "(?<=GPS Ref: )[0-9]+;[0-9]+"),
                       # split string on ";", simplify to a matrix
                       pattern = ";", n = 2, simplify = TRUE)
  
  # Unmatched lines have left "", replace with NAs
  matches <- na_if(matches, "")
  # column names for the matrix
  colnames(matches) <- c("easting", "northing")
  return(matches)
}


# End of 14-extract_eastnor.R ----------------------------------------------------


# 18-report.R -------------------------------------------------------------


# detect all rds files in cache
my_rds <- function(my_path) {list.files(my_path, pattern = ".rds")}

# assign all objects by their file prefix to the global environment
assign_objects <- function(filesincache) {
  # print object name
  obj_name <- sapply(str_split(filesincache, "\\."), `[[`, 1)
  # print path to file
  filepath <- paste0("../cache/", filesincache)
  
  # check the file exists, if so read in and assign
  if(file.exists(filepath)){
    # assign object to global environment
    assign(obj_name, readRDS(filepath), envir = .GlobalEnv)
    # print a confirmation statement to console
    print(paste("Assigned object", obj_name))
  }
}


# detect all files and assign them to named objects
assign_rds <- function(my_path){
  my_files <- my_rds(my_path)
  for (i in my_files){
    assign_objects(i)
  }
}

# End of 18-report.R -------------------------------------------------------------