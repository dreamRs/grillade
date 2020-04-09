
#' @importFrom htmltools htmlDependency
html_dependency_grillade <- function() {
  htmlDependency(
    name = "grillade", version = "7.1.0",
    src = list(file = "asssets", href = "grillade"),
    package = "grillade",
    stylesheet = c(
      "grillade/grillade-grid.css",
      "grillade-custom.css"
    )
  )
}



#' Title
#'
#' @param ...
#' @param n_col
#' @param cols_width
#' @param .list
#'
#' @return
#' @export
#'
#' @importFrom htmltools tags
#'
#' @examples
grillade <- function(..., n_col = NULL, cols_width = NULL, .list = NULL) {
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
        class = if(!is.null(cols_width)) grid_class(cols_width[i], "col"),
        class = if (inherits(content[[i]], "htmlwidget")) "grillade-Widget",
        tags$div(content[[i]])
      )
    }
  )
  content <- tags$div(
    class = grid_class(n_col, "grid"),
    content,
    html_dependency_grillade()
  )
  class(content) <- c("grillade", class(content))
  return(content)
}




