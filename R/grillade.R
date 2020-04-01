#' <Add Title>
#'
#' <Add Description>
#'
#' @importFrom htmlwidgets createWidget sizingPolicy
#' @importFrom htmltools tags tagList renderTags
#'
#' @export
grillade <- function(..., n_col = NULL, cols_width = NULL, .list = NULL, width = NULL, height = NULL, elementId = NULL) {
  stopifnot(is.numeric(n_col) | is.null(n_col))
  widgets <- list(...)
  if (is.list(.list)) {
    widgets <- c(widgets, .list)
  }

  if (!is.null(cols_width))
    cols_width <- rep_len(cols_width, length(widgets))

  # cols_height <- NULL
  # if (!is.null(n_col) && length(widgets) > n_col) {
  #   cols_height <- 100 / (((length(widgets) - 1) %/% n_col) + 1)
  #   cols_height <- paste0("height:", round(cols_height), "%;")
  # }

  widgets <- lapply(
    X = seq_along(widgets),
    FUN = function(i) {
      tags$div(
        class = if(!is.null(cols_width)) grid_class(cols_width[i], "col"),
        class = if (inherits(widgets[[i]], "htmlwidget")) "isWidget",
        style = "min-width: 0; min-height: 0; overflow: hidden; position: relative;",
        # style = cols_height,
        tags$div(widgets[[i]], style = "position: absolute; top:0; bottom:0; left:0; right:0;")
      )
    }
  )

  rendered <- renderTags(tagList(widgets))

  x <- list(
    html = rendered$html,
    params = list(
      class = grid_class(n_col, "grid"),
      style = "min-width: 0; min-height: 0;"
    )
  )

  createWidget(
    name = "grillade",
    x = x,
    width = width,
    height = height,
    package = "grillade",
    dependencies = rendered$dependencies,
    elementId = elementId,
    sizingPolicy = sizingPolicy(
      padding = 0,
      viewer.padding = 0,
      browser.padding = 0,
      viewer.fill = TRUE,
      browser.fill = TRUE
    )
  )
}


grillade_html <- function(id, style, class, ...) {
  tags$section(
    id = id, class = class, style = style, ...
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
