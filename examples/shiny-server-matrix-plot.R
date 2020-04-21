# Generate a matrix of plots from server ----------------------

library(grillade)
library(shiny)
library(ggplot2)

ui <- fluidPage(
  tags$h2("Matrix of plots with grillade"),
  sliderInput(
    inputId = "n",
    label = "Number of plots :",
    value = 3, min = 1, max = 15
  ),
  grilladeOutput("out")
)

server <- function(input, output, session) {

  output$out <- renderGrillade({
    lapply(
      X = seq_len(input$n),
      FUN = function(i) {
        ggplot() + geom_text(aes(1, 1, label = i), size = 50)
      }
    )
  }, max_n_col = 5)

}

if (interactive())
  shinyApp(ui, server)


