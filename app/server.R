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
        if(input$testpipeline == TRUE){
            s_date_string <- as.Date.character("01072019", "%d%m%Y")
            ui_message_start <- paste("Static test parameters used:",
                                    format(s_date_string, "%d-%b-%Y"))
        } else{
            s_date_string <- paste(format(input$user_start, "%d%m%Y"))
            ui_message_start <- paste("Start date set as:", format(input$user_start, "%d-%b-%Y"))
        }
        
        saveRDS(s_date_string, "../cache/start_date.rds")
        ui_message_start
    })
    

# end date ----------------------------------------------------------------

    # output end date if input$testpipeline == FALSE
    # else output the static test parameter
    output$end_date <- renderText({
        if(input$testpipeline == TRUE){
            e_date_string <- as.Date.character("01072019", "%d%m%Y")
            ui_message_end <- paste("Static test parameters used:",
                                    format(e_date_string, "%d-%b-%Y"))
        } else{
            e_date_string <- paste(format(input$user_end, "%d%m%Y"))
            ui_message_end <- paste("End date set as:", format(input$user_end, "%d-%b-%Y"))
        }

        saveRDS(e_date_string, "../cache/end_date.rds")
        ui_message_end
    })

})
