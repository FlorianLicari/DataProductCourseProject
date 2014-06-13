library(shiny)

shinyUI(pageWithSidebar(
        headerPanel("Developing Data Products - Course Project"), 
        sidebarPanel(
                h4("First, select the distribution to play with:"),
                wellPanel(radioButtons("distribution","",
                                       list("Central Normal","Central T-student"),
                                       selected="Central Normal")),
                h4("Then, enter your quantile:"),
                uiOutput("distName"),
                h4("Enjoy!")
        ),
        mainPanel(
                tags$style(type="text/css",
                           ".shiny-output-error { visibility: hidden; }",
                           ".shiny-output-error:before { visibility: hidden; }"
                ),
                h4("You have now information about your distribution:"),
                plotOutput('newDistribution')
        ) )
)
