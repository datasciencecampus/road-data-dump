"
Purpose of script:
House dependencies for application
"

# load packages -----------------------------------------------------------
library(shiny)
library(cicerone)
library(shinyhelper)


# check Email syntax ------------------------------------------------------

isValidEmail <- function(x) {
  grepl("\\<[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}\\>", as.character(x), 
        ignore.case=TRUE)
}
