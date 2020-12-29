"Purpose of script:
Produce a UI to assist users in setting query parameters and running pipeline
"
# source dependencies -----------------------------------------------------

source("dependencies.R")

ui <- fluidPage(
    # Use theme to style with custom css
    theme = "./style/style.css",
    # include the cicerone guide & dependencies
    use_cicerone(),
    # set content language for screen reader accessibility
    tags$head(HTML("<html lang='en'>"),
              includeCSS("./style/style.css")),
    # set page title for accessibility
    titlePanel(title = tags$header(
        class = "banner", tags$h1(
            # app name 
            tags$strong("Road Data Pipeline"), id = "appname"),
        # github link
        tags$a(href = "https://datasciencecampus.github.io/road-data-pipeline-documentation/",
               target='_blank',
               style='float:right',
               tags$strong("View Documentation"),
               id = "sourcecode",
               class = "source")),
        
        windowTitle = "Set Pipeline Parameters"),
    
    
    
    sidebarLayout(
        # sidebar -----------------------------------------------------------------
        
        # apply css styling to sidebar
        sidebarPanel(class = "sidebar",
                     width = 4,
                     actionButton(inputId = "guide", label = "Take a tour"),
                     fluidRow(id = "step1",
                              tags$h3("Step 1. Select start date."),

# select start date -------------------------------------------------------

                              # shinyhelper start date
                              helper(
                                  dateInput(inputId = "start_date",
                                            label = "Select a start date.",
                                            format = "dd-mm-yyyy"),
                                  type = "markdown",
                                  content = "lhs",
                                  colour = "#ce3487"
                              ),

# select end date ---------------------------------------------------------

                              
                              # shinyhelper end date
                              helper(
                                  dateInput(inputId = "end_date",
                                            label = "Select an end date.",
                                            format = "dd-mm-yyyy"),
                                  type = "markdown",
                                  content = "rhs",
                                  colour = "#ce3487"
                              )
                     ),
                     tags$hr(),
                     

# execute the pipeline ----------------------------------------------------

                     tags$br(),
                     tags$hr(),
                     tags$h3(id = "execute_title", "Step 4: Execute The Join!",
                             actionButton(
                                 inputId = "execute", label = "Go!", icon = icon("play-circle")))
                     
                     
        ),# end of sidebarlayout
        
        
        mainPanel(
            width = 8
                        
                        
        ) # end of mainPanel
    ) # end of sidebarlayout
) # end of fluid page