library(grillade)

box_example <- function(...) {
  tags$div(
    style = "box-sizing:border-box;border:5px solid #1C6EA4;height:100%;",
    ...
  )
}


# Two columns (automatic mode)
grillade(
  box_example("Column 1"),
  box_example("Column 2")
)

# Had a gutter between columns
grillade(
  box_example("Column 1"),
  box_example("Column 2"),
  gutter = TRUE
)


# Specify number of columns
grillade(
  box_example("Column 1"),
  box_example("Column 2"),
  box_example("Column 3"),
  n_col = 2,
  gutter = TRUE
)







