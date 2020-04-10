
#' @importFrom htmltools htmlDependency
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
#' @param ...
#' @param n_col
#' @param cols_width
#' @param gutter
#' @param .list
#'
#' @return
#' @export
#'
#' @importFrom htmltools tags
#'
#' @examples
grillade <- function(..., n_col = NULL, cols_width = NULL, gutter = FALSE, .list = NULL) {
  stopifnot(is.numeric(n_col) | is.null(n_col))
  content <- list(...)
  if (is.list(.list)) {
    content <- c(content, .list)
  }
  if (!is.null(cols_width))
    cols_width <- rep_len(cols_width, length(content))

  content <- lapply(
    X = seq_along(content),
    FUN = function(i) {
      tags$div(
        class = col_class(cols_width[i]),
        class = "grillade-column",
        class = if (inherits(content[[i]], "htmlwidget")) "grillade-widget",
        if (inherits(content[[i]], "htmlwidget")) {
          tags$div(content[[i]])
        } else {
          content[[i]]
        }
      )
    }
  )
  content <- tags$div(
    class = grid_class(n_col),
    class = gutter_class(gutter),
    content,
    html_dependency_grillade()
  )
  class(content) <- c("grillade", class(content))
  return(content)
}



#' Print method for grillade object
#'
#' @param x A \code{\link{grillade}} object.
#' @param ... Additional arguments.
#'
#' @export
#' @importFrom htmltools tags browsable tagAppendAttributes
#'
print.grillade <- function(x, ...) {
  TAG <- tags$html(
    style = "width: 100%; height: 100%;",
    tags$body(
      style = "width: 100%; height: 100%; margin: 0;",
      tagAppendAttributes(
        x,
        style = "width: 100%; height: 100%;"
      )
    )
  )
  print(browsable(TAG))
}








