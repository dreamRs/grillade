library(grillade)

# For examples
box_example <- function(...) {
  tags$div(
    style = "box-sizing:border-box;border:5px solid #1C6EA4;height:100%;",
    ...
  )
}

# Number of row taken by grid element
grillade(
  box_example("Column 1"),
  knack(
    row_height = 2,
    box_example("Column 2")
  ),
  box_example("Column 3"),
  n_col = 2,
  gutter = TRUE
)


# Specify columns width
grillade(
  knack(
    col_width = 3,
    box_example("Column 1")
  ),
  knack(
    col_width = 2,
    box_example("Column 2")
  ),
  knack(
    col_width = 2,
    box_example("Column 3")
  ),
  knack(
    col_width = 3,
    box_example("Column 4")
  ),
  n_col = 5,
  gutter = TRUE
)


