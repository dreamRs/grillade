#' <Add Title>
#'
#' <Add Description>
#'
#' @importFrom htmlwidgets createWidget sizingPolicy
#'
#' @export
grillade <- function(message, width = NULL, height = NULL, elementId = NULL) {

  x <- list(
    message = message
  )

  createWidget(
    name = "grillade",
    x = ,
    width = width,
    height = height,
    package = "grillade",
    elementId = elementId,
    sizingPolicy = sizingPolicy()
  )
}

#' Shiny bindings for grillade
#'
#' Output and render functions for using grillade within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a grillade
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name grillade-shiny
#'
#' @importFrom htmlwidgets shinyWidgetOutput
#'
#' @export
grilladeOutput <- function(outputId, width = "100%", height = "400px"){
  htmlwidgets::shinyWidgetOutput(outputId, "grillade", width, height, package = "grillade")
}

#' @rdname grillade-shiny
#' @export
#' @importFrom htmlwidgets shinyRenderWidget
renderGrillade <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, grilladeOutput, env, quoted = TRUE)
}
