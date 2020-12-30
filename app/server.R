source("dependencies.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

# Email_check -------------------------------------------------------------
# produce Email text
    output$Email_check <- renderText({
        # check format
        validate(
            # use basic Email format check in dependencies.R
            need(expr = isValidEmail(input$userEmail),
                 # if invalid, output a warning to user
                 message = paste(input$userEmail, "Email is invalid. Please Input a valid E-mail address"))
        ) #end of validate
        # if validated, save the text string for pipeline execution
        saveRDS(object = input$userEmail, file = "../cache/user_Email.rds")
        # return the validation message
        paste(input$userEmail, "is valid")
    }) # end of Email_check
    

# test run ----------------------------------------------------------------

    # output test_run status
    output$test_run <- renderText({
        # save status to cache
        saveRDS(input$testpipeline, "../cache/test_run.rds")
        # output message to console
        paste("Test run is", input$testpipeline)
    })

# start date --------------------------------------------------------------

    # output start date if input$testpipeline == FALSE
    # else output the static test parameter
    output$start_date <- renderText({
        s_date_string <- if_else(condition = input$testpipeline == TRUE,
                                 paste("Static test parameters used."),
                                 paste(format(input$user_start, "%d%m%Y")))
        saveRDS(s_date_string, "../cache/start_date.rds")
        paste("Start date is set as:", s_date_string)
    })
    

# end date ----------------------------------------------------------------

    # output end date if input$testpipeline == FALSE
    # else output the static test parameter
    output$end_date <- renderText({
        e_date_string <- if_else(condition = input$testpipeline == TRUE,
                                 paste("Static test parameters used."),
                                 paste(format(input$user_end, "%d%m%Y")))
        saveRDS(e_date_string, "../cache/end_date.rds")
        paste("End date is set as:", e_date_string)
    })

})
