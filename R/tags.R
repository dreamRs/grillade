
#' Grillade HTML dependency
#'
#' @return an \code{\link[htmltools]{htmlDependency}}.
#' @export
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




#' @title Create a grillade (grid) of elements
#'
#' @description Display plots, htmlwidgets or other HTML components in a grid.
#'
#' @param ... Elements to include in the \code{grillade}, must be HTML-like outputs.
#' @param n_col Number of columns, default to \code{NULL}
#'  and automatically display element with equal size in the grid.
#' @param max_n_col Maximum number of columns, used if \code{n_col = NULL}
#'  and number of elements is unknown.
#' @param cols_width Numeric vector, numbers of columns taken by each elements,
#'  can be a single number or a \code{vector} of same length as elements number.
#' @param gutter Add a gutter between columns, can be \code{TRUE}/\code{FALSE},
#'  or \code{"l"} or \code{"xl"}.
#' @param .list Alternative \code{list} of elements to include in the grid.
#' @param width,height Give explicit width and height to the \code{grillade}.
#'
#' @return HTML tags.
#' @export
#'
#' @importFrom htmltools tags findDependencies resolveDependencies attachDependencies
#' @importFrom shiny renderPlot
#'
#' @example examples/shiny-ui.R
#' @example examples/widget-viewer.R
grillade <- function(...,
                     n_col = NULL,
                     max_n_col = NULL,
                     cols_width = NULL,
                     gutter = FALSE,
                     .list = NULL,
                     width = NULL,
                     height = NULL) {
  stopifnot(is.numeric(n_col) | is.null(n_col))
  content <- list(...)
  if (is.list(.list)) {
    content <- c(content, .list)
  }
  if (!is.null(cols_width))
    cols_width <- rep_len(cols_width, length(content))

  if (is_tag(content)) {
    deps <- findDependencies(content)
    deps <- resolveDependencies(deps)
  } else {
    deps <- NULL
  }

  grll <- list(
    content = content,
    dependencies = deps,
    n_col = n_col,
    max_n_col = max_n_col,
    cols_width = cols_width,
    gutter = gutter,
    width = width, height = height
  )
  class(grll) <- "grillade"
  return(grll)
}






