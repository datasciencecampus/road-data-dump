"Purpose of script:
Produce a UI to assist users in setting query parameters and running pipeline
"

ui <- navbarPage("Menu",
                 id = "menu_bar",
                 selected = "Set Parameters",
                 position = "fixed-bottom",
                 
# first tabpanel ----------------------------------------------------------
                 
                 tabPanel("Set Parameters",
    tags$head(
        # set content language for screen reader accessibility
        HTML("<html lang='en'>"),
              # custom styling
              includeCSS("www/style/style.css"),
        # cicerone fixed navbar bug fix
        tags$style(
            HTML(
                "div#driver-highlighted-element-stage, div#driver-page-overlay {
  background: transparent !important;
  outline: 5000px solid rgba(0, 0, 0, .75)
}"
            )
        ),
              # message handler
              tags$script(src = "message-handler.js"),
              # include the cicerone guide & dependencies
              use_cicerone(),
              # use shinyjs for delay of pipeline execution
              useShinyjs(),
              # add a spinner when server is busy
              add_busy_spinner(spin = "fading-circle")
              ),

# title -------------------------------------------------------------------
    # set page title as h1 header for accessibility
    titlePanel(title = tags$header(
        class = "banner", tags$h1(
            # app name 
            tags$strong("Road Data Pipeline v2.0"), id = "appname"),
        
# tour button -------------------------------------------------------------
        actionButton(inputId = "guide", label = "Take a tour"),
        

# DSC logo ----------------------------------------------------------------

        tags$img(id = "logo", src = "DSC_LOGO_RGB_WHITE_300_DPI.png", width = 200, align = "right")
        
), # end of header
        
        windowTitle = "Road Data Pipeline"),



    sidebarLayout(
        # sidebar -----------------------------------------------------------------
        
        # apply css styling to sidebar
        sidebarPanel(class = "sidebar", id = "sidebar",
                     width = 4,
                     
# user Email --------------------------------------------------------------

fluidRow(id = "Email",
         tags$h4("Please provide your Email."),
         tags$span(id = "EmailInput",
         selectizeInput(inputId = "userEmail",
                          label = NULL,
                          options = list(create = TRUE,
                                         placeholder = "Type your Email and press Enter."),
                          choices = NULL)
         )
         ), # end of Email fluidrow


# testing -----------------------------------------------------------------

fluidRow(id = "testing",
         tags$h4("Test the pipeline?"),
         radioButtons(inputId = "testpipeline",
                      label = NULL,
                      choices = list("Testing" = TRUE,
                                     "Not Testing" = FALSE),
                      selected = TRUE,
                      inline = TRUE)
         ),

# daterange ---------------------------------------------------------------

fluidRow(id = "daterange",
         tags$h4("Select dates."),
         dateRangeInput(inputId = "daterange",
                        label = NULL,
                        format = "dd-mm-yyyy",
                        startview = "month",
                        weekstart = 1)
         ),#end of daterange fluid row

fluidRow(id = "chunk_size",
         tags$h4("Select Chunk Size"),
         numericInput(
           inputId = "chunk_size",
           label = "Chunk Size:", value = 10, min = 5, max = 100)
         ),

# execute the pipeline ----------------------------------------------------

fluidRow(id = "runpipeline",
    tags$h4("Run the pipeline.",
            actionButton(inputId = "execute",
                         label = "Go!",
                         icon = icon("play-circle"))))
        ),# end of sidebarlayout
        
# main panel --------------------------------------------------------------
        mainPanel(id = "mainpanel",
            width = 8,
            # github link
            HTML('
            <span id="codespan">
            <a id="sourcecode" href="https://datasciencecampus.github.io/road-data-pipeline-documentation/">
                    <strong>View Documentation</strong>
                 </a>
                 </span>
                 '),
            
            
            tags$div(id = "emailcheck",
            textOutput("Email_check")
            ),
            hr(),
            textOutput("test_run"),
            hr(),
            tags$div(id = "dateoutputs",
            textOutput("start_date"),
            hr(),
            textOutput("end_date"),
            hr(),
            textOutput("DateRangeOut"),
            hr()
            ),
            tags$div(id = "chunk",
            htmlOutput("chunk")
            ),
            hr(),
            tags$div(id = "pipstatus",
            htmlOutput("pipeline_status")
            ),
            hr(),
        ))))