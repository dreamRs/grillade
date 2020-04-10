
#' @importFrom htmltools htmlDependency
shiny_bindings_grillade <- function() {
  htmlDependency(
    name = "grillade-bindings",
    version = as.character(packageVersion("grillade")),
    src = list(file = "assets", href = "grillade"),
    package = "grillade",
    script = "grillade-bindings.js"
  )
}

#' Grillade Output in Shiny
#'
#' @param outputId Output variable to read from.
#' @param width If not \code{NULL}, must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param ... Other arguments to pass to the container tag function.
#'  This is useful for providing additional classes for the tag.
#'
#' @return An HTML output element that can be included in Shiny UI.
#' @export
#'
#' @importFrom htmltools tags validateCssUnit
#'
#' @name grillade-shiny
#'
#' @examples
grilladeOutput <- function(outputId, width = "100%", ...) {
  tags$div(
    id = outputId, class = "shiny-html-output grillade-output",
    style = if (!is.null(width)) paste0("width:", validateCssUnit(width), ";"),
    ...,
    shiny_bindings_grillade()
  )
}

#' @inheritParams grillade
#' @param expr An expression that generates a \code{\link{grillade}}.
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#' @rdname grillade-shiny
#' @export
#'
#' @importFrom shiny installExprFunction createRenderFunction
#' @importFrom htmltools renderTags
renderGrillade <- function(expr,
                           n_col = NULL, cols_width = NULL, gutter = FALSE,
                           env = parent.frame(),
                           quoted = FALSE,
                           outputArgs = list()) {
  shiny::installExprFunction(expr, "func", env, quoted)
  shiny::createRenderFunction(
    func = func,
    transform = function(result, shinysession, name, ...) {
      if (is.null(result) || length(result) == 0)
        return(NULL)
      if (inherits(result, "list")) {
        result <- grillade(
          .list = result,
          n_col = n_col,
          cols_width = cols_width,
          gutter = gutter
        )
      }
      if (!inherits(result, "grillade")) {
        stop(
          "renderGrillade: 'expr' must return a list or grillade object.",
          call. = FALSE
        )
      }
      rendered <- renderTags(result)
      list(html = rendered$html, deps = rendered$dependencies)
    }, grilladeOutput, outputArgs
  )
}
