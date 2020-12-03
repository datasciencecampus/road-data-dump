"
Purpose of script:
Contain custom functions for use in munge processing scripts
"


# 02.prep.R, direction function -------------------------------------------



# old direction function ------------------------------------------------------------
# direction <- function(x) {
#   # RLe - find the location of the direction string match within the name vector
#   m <- regexpr("(([A-Za-z]+)bound)|([A-Za-z\\\\-]+wise)", x, perl = TRUE)
#   # RLe - lower case the direction strings to a character vector
# matches <- tolower(regmatches(x, m))
# # matches does not include NA. do cumsum trick to map NAs:
# # m is a vector of match positions, where -nv = no match found.
# # cumsum over sign of m where -1 replaced with 0, so that non-matches are repeated.
# # then replace repeated with NA, as to get matches same length as input.
# # RLe - this bit is to remove NAs
# matches[ifelse(
#   m > 0, cumsum(
#     ifelse(
#       m > 0, 1, 0) # ifelse output is 1 0 1 1 1 1 1 1 1 1. If any negative indexes caused by empty character strings, then overwite to 0
#     ), # cumsum output is 1 1 2 3 4 5 6 7 8 9. cumulative sums the above vector
#   NA)# ifelse output is 1 NA  2  3  4  5  6  7  8  9. This has replaced 0s with NAs.
#   ]
# 
# }
# End of old direction function ------------------------------------------------------------



# new direction function ------------------------------------------------------------

direction <- function(x){
  #ensure output is lowered
  tolower(
    # extract all pattern matches, handles NAs gracefully
    str_extract(x, "(([A-Za-z]+)bound)|([A-Za-z\\\\-]+wise)")
  )
}

# End of new direction function ------------------------------------------------------------




# End of 02.prep.R, direction function -------------------------------------------



# 02.prep.R, easting northing function ------------------------------------

# extract easting and northing matrix

easting_northing <- function(x) {
  #find the pattern locations
  m <- regexpr("GPS Ref: [0-9]+;[0-9]+", x, perl = TRUE)
  #find the matches, remove anything other than coord vals, split by ";", extract as a 2 col matrix
  matches <- matrix(unlist(strsplit(sub("^.*: ", "", regmatches(x, m)), ";")), ncol=2, byrow=T)
  # line to handle negative indices, replacing with NAs
  matches <- matches[ifelse(m > 0, cumsum(ifelse(m > 0, 1, 0)), NA), ]
  # column names for the matrix
  colnames(matches) <- c("easting", "northing")
  matches
}

# end of 02.prep.R, easting northing function ------------------------------------

