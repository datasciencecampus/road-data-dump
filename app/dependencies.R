"
Purpose of script:
House dependencies for application
"


# detach jsonlite on reruns -----------------------------------------------
"jsonlite causing issue with validate Email message on app reruns within same
session. To avoid this, force unload on app initiation. Note that jsonlite is
still required in app by shinybusy, so implicit attachment on loading shinybusy
anyway."

pipelinePckgs <- dplyr::setdiff(names(sessionInfo()$otherPkgs),
                                c("shiny", "cicerone", "shinyjs", "shinybusy"))

if("jsonlite" %in% pipelinePckgs){
detach("package:jsonlite", force = TRUE, unload = TRUE, character.only = TRUE)
  rm(pipelinePckgs)
  
}


# load packages -----------------------------------------------------------
library(shiny)
library(cicerone)
library(shinyjs)
library(shinybusy)
library(base)


# check Email syntax ------------------------------------------------------

isValidEmail <- function(x) {
  grepl("\\<[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}\\>", as.character(x), 
        ignore.case = TRUE)
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
    el = "daterange",
    title = "Set the start and end dates.",
    description = "If testing, dates used are static and the selector widget will not
    respond to any user input. Select the start date on the left and the end date
    on the right. Dates are inclusive. Start date and end date can be the same,
    but start date cannot be more recent than end date. A maximum of 31 days in
    the specified date range is accepted by the pipeline."
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
    title = "Confirmation messages appear here.",
    position = "left"
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