
library(shiny)
library(apexcharter)
library(grillade)

data("economics", package = "ggplot2")

ui <- fluidPage(
  tags$h2("grillade : matrix of htmlwidgets in UI"),
  sliderInput(
    inputId = "date",
    label = "Date",
    min = as.Date("1967-07-01"),
    max = as.Date("2015-04-01"),
    value = c(
      as.Date("1967-07-01"),
      as.Date("2015-04-01")
    )
  ),
  grillade(
    n_col = 3,
    apexchartOutput(outputId = "plot1"),
    apexchartOutput(outputId = "plot2"),
    apexchartOutput(outputId = "plot3"),
    apexchartOutput(outputId = "plot4"),
    apexchartOutput(outputId = "plot5"),
    apexchartOutput(outputId = "plot6")
  )
)

server <- function(input, output, session) {

  r <- reactive({
    subset(
      economics,
      date >= input$date[1] & date <= input$date[2]
    )
  })

  output$plot1 <- renderApexchart({
    apex(
      data = r(),
      mapping = aes(x = date, y = pce),
      type = "line"
    )
  })

  output$plot2 <- renderApexchart({
    apex(
      data = r(),
      mapping = aes(x = date, y = pop),
      type = "line"
    )
  })

  output$plot3 <- renderApexchart({
    apex(
      data = r(),
      mapping = aes(x = date, y = psavert),
      type = "line"
    )
  })

  output$plot4 <- renderApexchart({
    apex(
      data = r(),
      mapping = aes(x = date, y = uempmed),
      type = "line"
    )
  })

  output$plot5 <- renderApexchart({
    apex(
      data = r(),
      mapping = aes(x = date, y = unemploy),
      type = "line"
    )
  })

}

shinyApp(ui, server)
