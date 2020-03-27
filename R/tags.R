
#' @importFrom htmltools htmlDependency
html_dependency_grillade <- function() {
  htmlDependency(
    name = "grillade", version = "7.1.0",
    src = list(file = "assets/grillade"),
    package = "grillade",
    stylesheet = "grillade-grid.css"
  )
}
