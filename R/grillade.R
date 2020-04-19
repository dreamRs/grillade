
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
#' @param width,height Give explicit width and height to the \code{grillade}.
#'
#' @return HTML tags.
#' @export
#'
#' @importFrom htmltools tags tagList findDependencies resolveDependencies attachDependencies
#' @importFrom shiny renderPlot
#'
#' @example examples/shiny-ui.R
#' @example examples/viewer-widget.R
grillade <- function(...,
                     n_col = NULL,
                     max_n_col = NULL,
                     cols_width = NULL,
                     gutter = FALSE,
                     .list = NULL,
                     width = NULL,
                     height = NULL) {
  stopifnot(is.numeric(n_col) | is.null(n_col))
  content <- list(...)
  if (is.list(.list)) {
    content <- c(content, .list)
  }
  if (!is.null(cols_width))
    cols_width <- rep_len(cols_width, length(content))

  if (is_tag(content) | any(is_widgets(content))) {
    deps <- findDependencies(tagList(content))
    deps <- resolveDependencies(deps)
  } else {
    deps <- NULL
  }

  grll <- list(
    content = content,
    dependencies = deps,
    n_col = n_col,
    max_n_col = max_n_col,
    cols_width = cols_width,
    gutter = gutter,
    width = width, height = height
  )
  class(grll) <- "grillade"
  return(grll)
}


build_grillade <- function(x, knitr = FALSE, shiny = FALSE, default_height = "400px") {
  content <- x$content

  heights <- get_heights(content, knitr = knitr)

  if (isTRUE(shiny)) {
    default_height <- rep_len(default_height, length.out = length(content))
    rendered <- is_widgets(content) | is_ggplots(content)
    heights[is.na(heights) & rendered] <- default_height[is.na(heights) & rendered]
  }

  content <- lapply(
    X = seq_along(content),
    FUN = function(i) {
      tags$div(
        class = col_class(x$cols_width[i]),
        class = "grillade-column",
        class = paste0("grillade-", i),
        class = if (is_widget(content[[i]])) "grillade-widget",
        style = if (!is.na(heights[i]))
          paste0("height:", heights[i], ";"),
        if (is_widget(content[[i]])) {
          if (isTRUE(shiny)) {
            content[[i]] <- makeRender(content[[i]], heights[i])
          }
          tags$div(content[[i]])
        } else {
          if (is_ggplot(content[[i]]) & isTRUE(shiny)) {
            renderPlot(content[[i]], quoted = TRUE)
          } else {
            content[[i]]
          }
        }
      )
    }
  )
  if (!is.null(x$max_n_col) && length(content) > x$max_n_col) {
    n_col <- x$max_n_col
  } else {
    n_col <- x$n_col
  }
  content <- tags$div(
    class = grid_class(n_col),
    class = gutter_class(x$gutter),
    style = if (!is.null(x$width))
      paste0("width:", validateCssUnit(x$width), ";"),
    style = if (!is.null(x$height))
      paste0("height:", validateCssUnit(x$height), ";"),
    content
  )
  content <- attachDependencies(
    x = content,
    value = c(
      x$dependencies,
      list(html_dependency_grillade())
    )
  )
  return(content)
}





