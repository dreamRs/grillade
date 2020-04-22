library(grillade)

box_example <- function(...) {
  tags$div(
    style = "box-sizing:border-box;border:5px solid #1C6EA4;height:100%;",
    ...
  )
}

# Two columns large screen, One for small
grillade(
  box_example("Column 1"),
  box_example("Column 2"),
  n_col = 2,
  n_col_sm = 1
)



# In Shiny UI
library(shiny)
library(apexcharter)
library(grillade)

data("economics", package = "ggplot2")

ui <- fluidPage(
  tags$h2("grillade : responsive"),
  grillade(
    n_col = 4, n_col_sm = 2,
    apexchartOutput(outputId = "plot1"),
    apexchartOutput(outputId = "plot2"),
    apexchartOutput(outputId = "plot3"),
    apexchartOutput(outputId = "plot4")
  )
)

server <- function(input, output, session) {

  output$plot1 <- renderApexchart({
    apex(
      data = economics,
      mapping = aes(x = date, y = pce),
      type = "line"
    )
  })

  output$plot2 <- renderApexchart({
    apex(
      data = economics,
      mapping = aes(x = date, y = pop),
      type = "line"
    )
  })

  output$plot3 <- renderApexchart({
    apex(
      data = economics,
      mapping = aes(x = date, y = psavert),
      type = "line"
    )
  })

  output$plot4 <- renderApexchart({
    apex(
      data = economics,
      mapping = aes(x = date, y = uempmed),
      type = "line"
    )
  })

}

if (interactive())
  shinyApp(ui, server)


