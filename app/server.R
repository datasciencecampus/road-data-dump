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
                 message = paste(input$userEmail, "is invalid. Please Input a valid E-mail address"))
        ) #end of validate
        # if validated, save the text string for pipeline execution
        saveRDS(object = input$userEmail, file = "../cache/user_Email.rds")
        # return the validation message
        paste(input$userEmail, "is valid")
    }) # end of Email_check


})
