# Grillade in Shiny UI ----------------------------------------------------

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
  ),
  tags$b("5 columns with gutter"),
  grillade(
    gutter = TRUE,
    wellPanel("Column 1", style = "text-align: center;"),
    wellPanel("Column 2", style = "text-align: center;"),
    wellPanel("Column 3", style = "text-align: center;"),
    wellPanel("Column 4", style = "text-align: center;"),
    wellPanel("Column 5", style = "text-align: center;")
  ),
  tags$b("5 columns with big gutter"),
  grillade(
    gutter = "xl",
    wellPanel("Column 1", style = "text-align: center;"),
    wellPanel("Column 2", style = "text-align: center;"),
    wellPanel("Column 3", style = "text-align: center;"),
    wellPanel("Column 4", style = "text-align: center;"),
    wellPanel("Column 5", style = "text-align: center;")
  ),
  tags$b("3 columns"),
  grillade(
    n_col = 3,
    wellPanel("Column 1", style = "text-align: center;"),
    wellPanel("Column 2", style = "text-align: center;"),
    wellPanel("Column 3", style = "text-align: center;"),
    wellPanel("Column 4 (will be on a 2nd row)", style = "text-align: center;"),
    wellPanel("Column 5 (will be on a 2nd row)", style = "text-align: center;")
  ),
  tags$b("4 columns & specific widths"),
  grillade(
    n_col = 4, cols_width = c(NA, 3, 2, 2, NA),
    wellPanel("Column 1", style = "text-align: center;"),
    wellPanel("Column 2 (take 3)", style = "text-align: center;"),
    wellPanel("Column 3 (take 2)", style = "text-align: center;"),
    wellPanel("Column 4 (take 2)", style = "text-align: center;"),
    wellPanel("Column 5", style = "text-align: center;")
  )
)

server <- function(input, output, session) {

}

if (interactive())
  shinyApp(ui, server)

