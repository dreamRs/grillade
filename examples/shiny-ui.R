
library(grillade)
library(shiny)

ui <- fluidPage(
  tags$h2("Grillade in Shiny UI"),
  tags$b("3 columns"),
  grillade(
    wellPanel("Column 1", style = "text-align: center;"),
    wellPanel("Column 2", style = "text-align: center;"),
    wellPanel("Column 3", style = "text-align: center;")
  ),
  tags$b("5 columns"),
  grillade(
    wellPanel("Column 1", style = "text-align: center;"),
    wellPanel("Column 2", style = "text-align: center;"),
    wellPanel("Column 3", style = "text-align: center;"),
    wellPanel("Column 4", style = "text-align: center;"),
    wellPanel("Column 5", style = "text-align: center;")
  )
)

server <- function(input, output, session) {

}

shinyApp(ui, server)
