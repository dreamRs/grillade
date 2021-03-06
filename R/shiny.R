
#' @importFrom htmltools htmlDependency
#' @importFrom utils packageVersion
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
#' @example examples/shiny-server.R
#' @example examples/shiny-server-matrix-widget-1.R
#' @example examples/shiny-server-matrix-plot.R
grilladeOutput <- function(outputId, width = "100%", ...) {
  tags$div(
    id = outputId, class = "shiny-html-output shiny-grillade-output",
    style = if (!is.null(width)) paste0("width:", validateCssUnit(width), ";"),
    ...,
    shiny_bindings_grillade()
  )
}

#' @param expr An expression that generates a \code{\link{grillade}}.
#' @inheritParams grillade
#' @param output_height Height to use for output(s),
#'  this apply to \code{htmlwidgets} and \code{ggplot2}.
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#' @rdname grillade-shiny
#' @export
#'
#' @importFrom shiny exprToFunction createRenderFunction createWebDependency
#' @importFrom htmltools renderTags resolveDependencies
renderGrillade <- function(expr,
                           n_col = NULL, max_n_col = NULL,
                           cols_width = NULL, gutter = FALSE,
                           output_height = "400px",
                           env = parent.frame(),
                           quoted = FALSE) {
  func <- shiny::exprToFunction(expr, env, quoted)
  shiny::createRenderFunction(
    func = func,
    transform = function(result, shinysession, name, ...) {
      if (is.null(result) || length(result) == 0)
        return(NULL)
      if (identical(class(result), "list")) {
        result <- grillade(
          .list = result,
          n_col = n_col,
          max_n_col = max_n_col,
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
      result <- build_grillade(result, shiny = TRUE, default_height = output_height)
      rendered <- renderTags(result)
      deps <- lapply(
        X = resolveDependencies(rendered$dependencies),
        FUN = createWebDependency
      )
      list(
        content = list(
          html = rendered$html, deps = deps
        ),
        outputHeight = output_height
      )
    }, grilladeOutput, list()
  )
}
