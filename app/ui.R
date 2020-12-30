"Purpose of script:
Produce a UI to assist users in setting query parameters and running pipeline
"
# source dependencies -----------------------------------------------------

source("dependencies.R")

ui <- fluidPage(
    # include the cicerone guide & dependencies
    use_cicerone(),
    # set content language for screen reader accessibility
    tags$head(HTML("<html lang='en'>"),
              includeCSS("www/style/style.css")),

# title -------------------------------------------------------------------
    # set page title for accessibility
    titlePanel(title = tags$header(
        class = "banner", tags$h1(
            # app name 
            tags$strong("Road Data Pipeline"), id = "appname"),
        
# tour button -------------------------------------------------------------
        actionButton(inputId = "guide", label = "Take a tour"),
        

# DSC logo ----------------------------------------------------------------

        tags$img(src = "DSC_LOGO_RGB_WHITE_300_DPI.png", width = 200, align = "right"),
        
), # end of header
        
        windowTitle = "Set Pipeline Parameters"),
    
    
    
    sidebarLayout(
        # sidebar -----------------------------------------------------------------
        
        # apply css styling to sidebar
        sidebarPanel(class = "sidebar",
                     width = 4,
                     
# user Email --------------------------------------------------------------

fluidRow(id = "Email",
         tags$h3("Please provide your Email."),
         helper(textInput(inputId = "userEmail",
                          label = NULL,
                          placeholder = "Enter your Email"),
                type = "markdown", content = "email", colour = "#ce3487")
         
         ), # end of Email fluidrow

fluidRow(id = "testing",
         tags$h3("Test the pipeline?"),
         helper(radioButtons(inputId = "testpipeline",
                             label = NULL,
                               choices = list("Testing" = TRUE,
                                              "Not Testing" = FALSE), 
                               selected = TRUE,inline = TRUE,width = "500px"),
                type = "markdown", content = "test", colour = "#ce3487")
         ),

# start date --------------------------------------------------------------

                     fluidRow(id = "step1",
                              
                              tags$h3("Select start date."),
         
                              # shinyhelper start date
                              helper(
                                  dateInput(inputId = "user_start",
                                            label = NULL,
                                            format = "dd-mm-yyyy",
                                            value = "2020-09-01"),
                                  type = "markdown",
                                  content = "lhs",
                                  colour = "#ce3487"
                              )),

# end date ----------------------------------------------------------------

                              fluidRow(id = "step2",
                                       
                                       tags$h3("Select end date."),
                                       
                                       # shinyhelper start date
                                       helper(
                                           dateInput(inputId = "user_end",
                                                     label = NULL,
                                                     format = "dd-mm-yyyy",
                                                     value = "2020-09-01"),
                                           type = "markdown",
                                           content = "rhs",
                                           colour = "#ce3487"
                                       )),
# execute the pipeline ----------------------------------------------------

fluidRow(
    tags$h3("Run the pipeline.",
            actionButton(inputId = "execute",
                         label = "Go!",
                         icon = icon("play-circle")))),
        ),# end of sidebarlayout
        
# main panel --------------------------------------------------------------

        mainPanel(
            width = 8,
            # github link
            tags$a(href = "https://datasciencecampus.github.io/road-data-pipeline-documentation/",
                   target='_blank',
                   style='float:right',
                   tags$strong("View Documentation"),
                   id = "sourcecode",
                   class = "source"),
            
            textOutput("Email_check"),
            hr(),
            textOutput("test_run"),
            hr(),
            textOutput("start_date"),
            hr(),
            textOutput("end_date")
                        
                        
        ) # end of mainPanel
    ) # end of sidebarlayout
) # end of fluid page