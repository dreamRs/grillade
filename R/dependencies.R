
#' @title Grillade HTML dependency
#'
#' @description Those functions can be used to load
#'  \href{https://www.knacss.com/doc.html#grids}{grillade} explicitly.
#'  \code{use_grillade} can be used in a RMakrdown chunk.
#'
#' @return an \code{\link[htmltools]{htmlDependency}}.
#' @export
#'
#' @name grillade-dependency
#'
#' @importFrom htmltools htmlDependency
#'
html_dependency_grillade <- function() {
  htmlDependency(
    name = "grillade",
    version = "7.1.0",
    src = list(file = "assets", href = "grillade"),
    package = "grillade",
    stylesheet = c(
      "grillade/grillade-grid.css",
      "grillade-custom.css"
    )
  )
}

#' @export
#'
#' @rdname grillade-dependency
#'
#' @importFrom htmltools attachDependencies tags
use_grillade <- function() {
  attachDependencies(
    x = tags$div(),
    value = html_dependency_grillade()
  )
}




