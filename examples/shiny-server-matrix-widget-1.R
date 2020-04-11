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
      type = "line"
    )
  }

  output$charts <- renderGrillade({
    chart1 <- make_chart(economics, "pce")
    chart2 <- make_chart(economics, "psavert")
    chart3 <- make_chart(economics, "uempmed")
    grillade(chart1, chart2, chart3)
  })

}

shinyApp(ui, server)
