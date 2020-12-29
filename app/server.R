source("dependencies.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$Email_check <- renderText({
        validate(
            need(expr = isValidEmail(input$userEmail),
                 message = paste("Please Input a valid E-mail address"))

        )
        input$userEmail
    
    })


})
