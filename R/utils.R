
grid_class <- function(x) {
  if (is.null(x))
    return("autogrid")
  paste("grid", x, sep = "-")
}

col_class <- function(x) {
  if (is.null(x) || is.na(x))
    return(NULL)
  paste("col", x, sep = "-")
}

gutter_class <- function(x) {
  if (isTRUE(x))
    return("has-gutter")
  if (identical(x, "l"))
    return("has-gutter-l")
  if (identical(x, "xl"))
    return("has-gutter-xl")
  return(NULL)
}

#' @importFrom shiny renderPlot
check_list <- function(x) {
  lapply(
    X = x,
    FUN = function(y) {
      if (inherits(y, "ggplot")) {
        renderPlot(y)
      } else {
        y
      }
    }
  )
}

#' @importFrom shiny getDefaultReactiveDomain
is_shiny <- function() {
  !is.null(getDefaultReactiveDomain())
}

is_widget <- function(x) {
  inherits(x, "htmlwidget")
}




