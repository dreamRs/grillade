
library(grillade)

box_example <- function(...) {
  tags$div(
    style = "box-sizing:border-box;border:5px solid #1C6EA4;height:100%;",
    ...
  )
}

# Using autogrid: as many columns as elements
grillade(
  box_example("Column 1"),
  box_example("Column 2"),
  box_example("Column 3"),
  box_example("Column 4"),
  box_example("Column 5")
)

# Custom number of cols and elements
grillade(
  n_col = 3,
  knack(
    cols = 2,
    box_example("Column 1")
  ),
  box_example("Column 2"),
  box_example("Column 3"),
  knack(
    cols = 2,
    rows = 2,
    box_example("Column 4")
  ),
  box_example("Column 5")
)
