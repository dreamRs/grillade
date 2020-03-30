
#' @importFrom htmltools htmlDependency
html_dependency_grillade <- function() {
  htmlDependency(
    name = "grillade", version = "7.1.0",
    src = list(file = "htmlwidgets/grillade"),
    package = "grillade",
    stylesheet = "grillade-grid.css"
  )
}

html_dependency_gridlex <- function() {
  htmlDependency(
    name = "gridlex", version = "2.7.1",
    src = list(file = "htmlwidgets/gridlex"),
    package = "grillade",
    stylesheet = "gridlex.min.css"
  )
}
