# Matrix of htmlwidgets ---------------------------------------------------

library(shiny)
library(ggplot2)
library(apexcharter)
library(grillade)

ui <- fluidPage(
  tags$h2("Htmlwidgets matrix example with grillade"),

  grilladeOutput("charts")

)

server <- function(input, output, session) {

  make_chart <- function(data, variable) {
    apex(
      data = data,
      mapping = aes(x = date, y = !!sym(variable)),
      type = "line", height = "400px"
    )
  }

  output$charts <- renderGrillade({
    a1 <- make_chart(economics, "pce")
    a2 <- make_chart(economics, "psavert")
    a3 <- make_chart(economics, "uempmed")
    grillade(a1, a2, a3)
  })

}

shinyApp(ui, server)
