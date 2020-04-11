
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

  deps <- findDependencies(content)
  deps <- resolveDependencies(deps)

  content <- lapply(
    X = seq_along(content),
    FUN = function(i) {
      tags$div(
        class = col_class(cols_width[i]),
        class = if (!is_shiny()) "grillade-column",
        style = if (is_shiny() & is_widget(content[[i]])) paste0("height:", widget_height[i], ";"),
        class = if (is_widget(content[[i]])) "grillade-widget",
        if (is_widget(content[[i]])) {
          if (is_shiny()) {
            # content[[i]]$height <- validateCssUnit(widget_height[i])
            content[[i]] <- makeRender(content[[i]])(content[[i]])
          }
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
    content
  )
  content <- htmltools::attachDependencies(
    x = content,
    value = c(
      deps,
      list(html_dependency_grillade())
    )
  )
  class(content) <- c("grillade", class(content))
  return(content)
}


makeRender <- function(widget) {
  widget <- force(widget)
  name <- attr(widget, "class")[1]
  package <- attr(widget, "package")
  function(expr, env = parent.frame()) {
    htmlwidgets::shinyRenderWidget(expr, function(outputId, width = "100%", height = "400px"){
      htmlwidgets::shinyWidgetOutput(
        outputId = outputId,
        name = name,
        width = width,
        height = height,
        package = package
      )
    }, env, quoted = TRUE)
  }
}

anyWidgetOutput <- function(outputId, width = "100%", height = "400px"){
  htmlwidgets::shinyWidgetOutput(outputId, "grillade-tag", width, height, package = "grillade")
}
renderAnyWidget <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, anyWidgetOutput, env, quoted = TRUE)
}

shinyRenderWidget2 <- function (expr, outputFunction, env, quoted) {
  func <- shiny::exprToFunction(expr, env, quoted)
  renderWidget <- function(instance) {
    # browser()
    if (!is.null(instance$elementId)) {
      warning("Ignoring explicitly provided widget ID \"",
              instance$elementId, "\"; Shiny doesn't use them")
    }
    if (!is.null(instance$prepend)) {
      warning("Ignoring prepended content; prependContent can't be used in a ",
              "Shiny render call")
    }
    if (!is.null(instance$append)) {
      warning("Ignoring appended content; appendContent can't be used in a ",
              "Shiny render call")
    }
    deps <- .subset2(instance, "dependencies")
    deps <- lapply(htmltools::resolveDependencies(deps),
                   shiny::createWebDependency)
    payload <- c(createPayload(instance), list(deps = deps))
    toJSON(payload)
  }
  shiny::markRenderFunction(outputFunction, function() {
    renderWidget(func())
  })
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








