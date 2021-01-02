"
Purpose of script:
House dependencies for application
"

# load packages -----------------------------------------------------------
library(shiny)
library(cicerone)
library(shinyjs)
library(shinybusy)


# check Email syntax ------------------------------------------------------

isValidEmail <- function(x) {
  grepl("\\<[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}\\>", as.character(x), 
        ignore.case=TRUE)
}

# guide to application use using cicerone ---------------------------------

guide <- Cicerone$
  new()$
  step(
    el = "sourcecode",
    title = "See the full pipeline documentation on GitHub."
  )$
  step(
    el = "Email",
    title = "Input your Email.",
    description = "Emails are sent to Highways England api along with the queries."
  )$
  step(
    el = "testing",
    title = "Are you testing the pipeline?",
    description = "Testing the pipeline limits the query to one site ID only (siteID 2).
    Only one day will be queried (1stJuly 2019). If you hear a chime once the app stops
    running, the pipeline is operational."
  )$
  step(
    el = "s_date",
    title = "Setting the start date.",
    description = "Select the start date for your query.
    This value should not be more recent than the end date, this will cause the pipeline to return
    an error. Start date can be the same as the end date when querying just one day. Note:
    Start date will not be selectable if testing."
  )$
  step(
    el = "e_date",
    title = "Setting the end date.",
    description = "Select the end date for your query.
    This value should not precede the start date, this will cause the pipeline to return
    an error. End date can be the same as the start date when querying just one day. Note:
    End date will not be selectable if testing."
  )$
  step(
    el = "runpipeline",
    title = "Click to execute the pipeline scripts.",
    description = "To interrupt this, you should close the app and ensure it has stopped running
    in R Studio. A spinner should appear at the top-right corner of the screen while the app is
    running. If the pipeline executes fully, you should hear a chime."
  )$
  step(
    el = "mainpanel",
    title = "Confirmation messages appear here."
  )$
  step(
    el = "emailcheck",
    title = "Email Validation",
    description = "The app won't execute the pipeline unless the Email is valid."
  )$
  step(
    el = "dateoutputs",
    title = "Dates specified.",
    description = "If testing, these dates are static and will not respond to any inputs
    specified. The format here is for presentation purposes only. Format passed to the
    pipeline is 'DDMMYYYY'."
  )$
  step(
    el = "pipstatus",
    title = "Pipeline status.",
    description = "Indicates whether the pipeline is inactive or running."
  )