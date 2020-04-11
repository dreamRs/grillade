
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
#'
#' @return HTML tags.
#' @export
#'
#' @importFrom htmltools tags
#'
#' @example examples/shiny-ui.R
#' @example examples/widget-viewer.R
grillade <- function(..., n_col = NULL, max_n_col = NULL, cols_width = NULL, gutter = FALSE, widget_height = "400px", .list = NULL) {
  stopifnot(is.numeric(n_col) | is.null(n_col))
  content <- list(...)
  if (is.list(.list)) {
    content <- c(content, .list)
  }
  if (!is.null(cols_width))
    cols_width <- rep_len(cols_width, length(content))

  widget_height <- rep_len(widget_height, length(content))

  content <- lapply(
    X = seq_along(content),
    FUN = function(i) {
      tags$div(
        class = col_class(cols_width[i]),
        class = if (!is_shiny()) "grillade-column",
        style = if (is_shiny() & is_widget(content[[i]])) paste0("height:", widget_height[i], ";"),
        class = if (is_widget(content[[i]])) "grillade-widget",
        if (is_widget(content[[i]])) {
          if (is_shiny())
            content[[i]]$height <- validateCssUnit(widget_height[i])
          tags$div(content[[i]])
        } else {
          content[[i]]
        }
      )
    }
  )
  if (!is.null(max_n_col) && length(content) > max_n_col)
    n_col <- max_n_col
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
        style = "width: 100%; height: 100%;",
        class = "viewer-grillade-ouptut"
      )
    )
  )
  print(browsable(TAG))
}








