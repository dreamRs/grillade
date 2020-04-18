
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


#' @importFrom shiny getDefaultReactiveDomain
is_shiny <- function() {
  !is.null(getDefaultReactiveDomain())
}

is_widget <- function(x) {
  inherits(x, "htmlwidget")
}

is_ggplot <- function(x) {
  inherits(x, "ggplot")
}

is_tag <- function(x) {
  inherits(x, c("shiny.tag", "shiny.tag.list"))
}

#' @importFrom htmlwidgets shinyRenderWidget shinyWidgetOutput
makeRender <- function(widget, height = "400px") {
  widget <- force(widget)
  height <- force(height)
  name <- attr(widget, "class")[1]
  package <- attr(widget, "package")
  shinyRenderWidget(widget, function(outputId) {
    shinyWidgetOutput(
      outputId = outputId,
      name = name,
      width = "100%",
      height = height,
      package = package
    )
  }, parent.frame(), quoted = TRUE)
}


