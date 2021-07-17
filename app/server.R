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
        if(input$userEmail == ""){
            paste("Please enter a valid Email address.")
        } else {
        # check format
        validate(
            # use basic Email format check in dependencies.R
            need(expr = isValidEmail(input$userEmail),
                 # if invalid, output a warning to user
                 message = paste(input$userEmail, "is invalid. Please input a valid Email address."))
        ) #end of validate
        # if validated, save the text string for pipeline execution
        saveRDS(object = input$userEmail, file = "../cache/user_Email.rds")
        # return the validation message
        paste(input$userEmail, "is valid.")
        }
    }) # end of Email_check
    
# Chunk Size ----------------------------------------------------------------
    
    output$chunk <- renderText({
        # save status to cache
        saveRDS(input$chunk_size, "../cache/chunk_size.rds")
        # output message to console
        paste("Chunk Size:", input$chunk_size)
        })
    

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
    

# date handling -----------------------------------------------------------

    #calculate selected date range
    # as date range is inclusive of start and end date, plus one
    selectedDateRange <- reactive({(input$daterange[2] - input$daterange[1] + 1)})
    
    
#  and present as text
    output$DateRangeOut <- renderText({
        ui_message_drange <- paste(
            "Selected date range:",
            selectedDateRange(),
            "day(s).")
        ui_message_drange
        })
    

# run pipeline ------------------------------------------------------------
    # default pipeline status
    pipeline_status <- reactiveValues(outputText = "Pipeline inactive.")
    
    
    "Run logic:
            1. Always check for Email validation and output message if not valid
            2. If testing, skip date handling logic
            3. If not testing, check dates between 0 and 31 days, output message if
            FALSE
            4. If Email is valid and dates are good, execute pipeline
            5. Else, pipeline is idle
            "
    # run the pipeline on action button press, if Email is validated.
    observeEvent(input$execute, {
        # check Email
        if(isValidEmail(input$userEmail) == FALSE){
            # send a browser message on press execute
            session$sendCustomMessage(type = 'testmessage',
                                      message = 'Valid Email required')
        } else if(
            # if testing, skip date handling logic
            input$testpipeline == TRUE
            ){
            # send a browser message on press execute
            session$sendCustomMessage(type = 'testmessage',
                                      message = 'Testing pipeline. Pipeline initiated.')
            # update pipeline status
            pipeline_status$outputText <- "Pipeline running."
            # Use shinyjs::delay() to prevent source executing before confirmation messages
            # run pipeline
            delay(ms = 1, expr =  source("../src/run-me.R"))
            # update pipeline status with confirmation message
            delay(ms = 2, expr =  pipeline_status$outputText <- pipeline_message)
        } 
        # else if (
        #     # if daterange is not within 31 days
        #     (between(
        #         selectedDateRange(),0, 31)
        #      ) == FALSE &&
        #     input$testpipeline == FALSE
        # ){
        #     # send a browser message on press execute
        #     session$sendCustomMessage(type = 'testmessage',
        #                               message = 'Dates selected must result in a positive date range of 31 days or less.'
        #                               )
        #     } 
        else if(
            # if both conditions above are met, successful run
            isValidEmail(input$userEmail) == TRUE 
                #&&
                # check daterange is 1 month only
                #between(selectedDateRange(),0, 31)
            ){
            # send a browser message on press execute
                session$sendCustomMessage(type = 'testmessage',
                                          message = 'Pipeline initiated.')
        # update pipeline status
        pipeline_status$outputText <- "Pipeline running."

        # Use shinyjs::delay() to prevent source executing before confirmation messages
        # run pipeline
        delay(ms = 1, expr =  source("../src/run-me.R"))
        # update pipeline status with confirmation message
        delay(ms = 2, expr = pipeline_status$outputText <- pipeline_message)
        }
    })
    
    # continue to update pipeline status text
    observe({
        output$pipeline_status <- renderText(HTML(pipeline_status$outputText))
        
        })

}) # end of server
