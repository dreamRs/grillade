
library(shiny)
library(ggplot2)
library(grillade)

ui <- fluidPage(
  tags$h2("grillade: two columns layout"),
  grillade(
    # n_col = 8,
    cols_width = c(3, 5),
    tagList(
      sliderInput(
        inputId = "date",
        label = "Date",
        min = as.Date("1967-07-01"),
        max = as.Date("2015-04-01"),
        value = c(
          as.Date("1967-07-01"),
          as.Date("2015-04-01")
        ),
        width = "100%"
      ),
      selectInput(
        inputId = "var",
        label = "Variable",
        choices = c("pce", "pop", "psavert", "uempmed", "unemploy"),
        width = "100%"
      )
    ),
    plotOutput(outputId = "plot")
  )
)

server <- function(input, output, session) {

  output$plot <- renderPlot({
    ggplot(data = economics) +
      aes(x = date, y = !!sym(input$var)) +
      geom_line() +
      xlim(input$date)
  })

}

shinyApp(ui, server)



