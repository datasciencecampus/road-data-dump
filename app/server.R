source("dependencies.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    
    # application guide -------------------------------------------------------
    
    guide$init()
    
    
    observeEvent(input$guide, {
        guide$start()
    })
    

# Email_check -------------------------------------------------------------


    # produce Email text
    output$Email_check <- renderText({
        # check format
        validate(
            # use basic Email format check in dependencies.R
            need(expr = isValidEmail(input$userEmail),
                 # if invalid, output a warning to user
                 message = paste(input$userEmail, "Email is invalid. Please Input a valid Email address"))
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
            ui_message_start <- paste("Static start date used:",
                                    format(s_date_string, "%d-%b-%Y"))
            saveRDS(s_date_string, "../cache/start_date.rds")
            
        } else{
            s_date_string <- paste(format(input$daterange[1], "%d%m%Y"))
            ui_message_start <- paste("Start date set as:", format(input$daterange[1], "%d-%b-%Y"))
            saveRDS(s_date_string, "../cache/start_date.rds")
        }
        
        ui_message_start
    }) # end of output$start_date
    
    # enable/disable the input date parameter based on testing status
    observe({
        toggleState(id = "daterange", condition = input$testpipeline == FALSE)
    })

# end date ----------------------------------------------------------------

    # output end date if input$testpipeline == FALSE
    # else output the static test parameter
    output$end_date <- renderText({
        if(input$testpipeline == TRUE){
            e_date_string <- as.Date.character("01072019", "%d%m%Y")
            ui_message_end <- paste("Static end date used:",
                                    format(e_date_string, "%d-%b-%Y"))
            saveRDS(e_date_string, "../cache/end_date.rds")
            
        } else{
            e_date_string <- paste(format(input$daterange[2], "%d%m%Y"))
            ui_message_end <- paste("End date set as:", format(input$daterange[2], "%d-%b-%Y"))
            saveRDS(e_date_string, "../cache/end_date.rds")
        }

        ui_message_end
    }) # end of output$end_date
    
    # enable/disable the input date parameter based on testing status
    observe({
        toggleState(id = "user_end", condition = input$testpipeline == FALSE)
    })
    

# run pipeline ------------------------------------------------------------
    # default pipeline status
    pipeline_status <- reactiveValues(outputText = "Pipeline inactive.")
    
    # run the pipeline on action button press, if Email is validated.
    observeEvent(input$execute, {
        if(isValidEmail(input$userEmail) == TRUE){
            # send a browser message on press execute
            observeEvent(input$execute, {
                session$sendCustomMessage(type = 'testmessage',
                                          message = 'Pipeline initiated.')
                })
        # update pipeline status
        pipeline_status$outputText <- "Pipeline running."

        # Use shinyjs::delay() to prevent source executing before confirmation messages
        # run pipeline
        delay(ms = 1, expr =  source("../src/run-me.R"))
        # update pipeline status with confirmation message
        delay(ms = 2, expr =  pipeline_status$outputText <- "Pipeline Executed.")
        } else {
            pipeline_status$outputText <- "Pipeline not initiated. Please enter a valid Email address."
        }
    })
    
    # continue to update pipeline status text
    observe(output$pipeline_status <- renderText(HTML(pipeline_status$outputText)))


# view midas table --------------------------------------------------------

    output$midas <- renderDT({
        if(pipeline_status$outputText == "Pipeline Executed."){
            return(midas)
        } else {
            return(data.frame("MIDAS" = "No data"))
        }
    })
    
    output$tame <- renderDT({
        if(pipeline_status$outputText == "Pipeline Executed."){
            return(tame)
        } else {
            return(data.frame("TAME" = "No data"))
        }
    })
    
    output$tmu <- renderDT({
        if(pipeline_status$outputText == "Pipeline Executed."){
            return(tmu)
        } else {
            return(data.frame("TMU" = "No data"))
        }
    })
    
    
}) # end of server
