
library(grillade)
library(shiny)

ui <- fluidPage(
  tags$h2("Grillade from server"),
  sliderInput(
    inputId = "n",
    label = "Number of elements :",
    value = 3, min = 1, max = 24
  ),
  grilladeOutput("out")
)

server <- function(input, output, session) {

  output$out <- renderGrillade({
    lapply(
      X = seq_len(input$n),
      FUN = function(i) {
        wellPanel(
          paste("Column", i),
          style = "text-align: center;"
        )
      }
    )
  })

}

shinyApp(ui, server)
