
library(shiny)
library(ggplot2)
library(grillade)

ui <- fluidPage(
  tags$h2("grillade : matrix of plots in UI"),
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
    plotOutput(outputId = "plot1"),
    plotOutput(outputId = "plot2"),
    plotOutput(outputId = "plot3"),
    plotOutput(outputId = "plot4"),
    plotOutput(outputId = "plot5"),
    plotOutput(outputId = "plot6")
  )
)

server <- function(input, output, session) {

  output$plot1 <- renderPlot({
    ggplot(data = economics) +
      aes(x = date, y = pce) +
      geom_line() +
      xlim(input$date)
  })

  output$plot2 <- renderPlot({
    ggplot(data = economics) +
      aes(x = date, y = pop) +
      geom_line() +
      xlim(input$date)
  })

  output$plot3 <- renderPlot({
    ggplot(data = economics) +
      aes(x = date, y = psavert) +
      geom_line() +
      xlim(input$date)
  })

  output$plot4 <- renderPlot({
    ggplot(data = economics) +
      aes(x = date, y = uempmed) +
      geom_line() +
      xlim(input$date)
  })

  output$plot5 <- renderPlot({
    ggplot(data = economics) +
      aes(x = date, y = unemploy) +
      geom_line() +
      xlim(input$date)
  })

}

shinyApp(ui, server)
