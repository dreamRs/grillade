# Matrix of htmlwidgets ---------------------------------------------------

library(shiny)
library(ggplot2)
library(apexcharter)
library(grillade)

ui <- fluidPage(
  tags$h2("Htmlwidgets matrix example with grillade"),

  grillade(
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
      selected = c("pce", "pop"),
      width = "100%",
      multiple = TRUE
    )
  ),

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

  r <- reactive({
    subset(
      economics,
      date >= input$date[1] & date <= input$date[2]
    )
  })

  output$charts <- renderGrillade({
    charts <- lapply(input$var, make_chart, data = r())
    grillade(.list = charts, max_n_col = 3)
  })

}

shinyApp(ui, server)
