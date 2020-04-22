
#' @title Create a grillade (grid) of elements
#'
#' @description Display plots, htmlwidgets or other HTML components in a grid.
#'
#' @param ... Elements to include in the \code{grillade}, must be HTML-like outputs.
#' @param n_col Number of columns, default to \code{NULL}
#'  and automatically display element with equal size in the grid.
#' @param n_col_sm Number of columns with small screen.
#' @param max_n_col Maximum number of columns, used if \code{n_col = NULL}
#'  and number of elements is unknown.
#' @param cols_width Numeric vector, numbers of columns taken by each elements,
#'  can be a single number or a \code{vector} of same length as elements number.
#' @param cols_width_sm Similar to \code{cols_width} but apply for small screens.
#' @param gutter Add a gutter between columns, can be \code{TRUE}/\code{FALSE},
#'  or \code{"l"} or \code{"xl"}.
#' @param .list Alternative \code{list} of elements to include in the grid.
#'
#' @return A \code{grillade} object that can be used in the console, in shiny application and in markdown document.
#' @export
#'
#' @importFrom htmltools tags tagList findDependencies resolveDependencies attachDependencies
#' @importFrom shiny renderPlot
#'
#' @example examples/shiny-ui.R
#' @example examples/viewer-widget.R
grillade <- function(...,
                     n_col = NULL,
                     n_col_sm = NULL,
                     max_n_col = NULL,
                     cols_width = NULL,
                     cols_width_sm = NULL,
                     gutter = FALSE,
                     .list = NULL) {
  stopifnot(is.numeric(n_col) | is.null(n_col))
  content <- list(...)
  if (is.list(.list)) {
    content <- c(content, .list)
  }
  if (!is.null(cols_width))
    cols_width <- rep_len(cols_width, length(content))
  if (!is.null(cols_width_sm))
    cols_width_sm <- rep_len(cols_width_sm, length(content))

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
    n_col_sm = n_col_sm,
    max_n_col = max_n_col,
    cols_width = cols_width,
    cols_width_sm = cols_width_sm,
    gutter = gutter
  )
  class(grll) <- "grillade"
  return(grll)
}



#' @title Grillade knack
#'
#' @description Custom elements for \code{\link{grillade}}.
#'
#' @param ... Content of the column, named arguments will be used as tag attributes.
#' @param cols Number of column taken by the element.
#' @param cols_sm Number of column taken by the element on small screen.
#' @param rows Number of rows taken by the element.
#'
#' @return An element that can be used inside \code{\link{grillade}}.
#' @export
#'
#' @example examples/ex-knack.R
knack <- function(..., cols = NULL, cols_sm = NULL, rows = NULL) {
  if (!is.null(cols_sm) & is.null(cols))
    stop(
      "If providing cols_sm (small screen size), ",
      "you have to provide cols (large screen size) too.",
      call. = FALSE
    )
  content <- list(...)
  if (any(nzchar(names(content)))) {
    attribs <- content[nzchar(names(content))]
    content[nzchar(names(content))] <- NULL
  } else {
    attribs <- NULL
  }
  obj <- list(
    content = content,
    col_width = cols,
    col_width_sm = cols_sm,
    row_height = rows,
    attribs = attribs
  )
  class(obj) <- c(class(obj), "knack")
  return(obj)
}


#' @importFrom htmltools tags
#' @importFrom shiny renderPlot
build_knack <- function(content,
                        col_width = NULL,
                        col_width_sm = NULL,
                        row_height = NULL,
                        css_height = NULL,
                        shiny = FALSE,
                        attribs = NULL) {
  knackTag <- tags$div(
    class = col_class(col_width, col_width_sm),
    class = row_class(row_height),
    class = "grillade-column",
    class = if (is_widget(content)) "grillade-widget",
    style = if (!is.null(css_height) && !is.na(css_height))
      paste0("height:", css_height, ";"),
    if (is_widget(content)) {
      if (isTRUE(shiny)) {
        content <- makeRender(content, css_height)
      }
      tags$div(content)
    } else {
      if (is_ggplot(content) & isTRUE(shiny)) {
        renderPlot(content, quoted = TRUE)
      } else {
        content
      }
    }
  )
  if (!is.null(attribs)) {
    knackTag$attribs <- c(knackTag$attribs, attribs)
  }
  return(knackTag)
}


#' @importFrom htmltools tags tagAppendAttributes attachDependencies validateCssUnit
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
      if (inherits(content[[i]], "knack")) {
        coltag <- build_knack(
          content = content[[i]]$content,
          col_width = content[[i]]$col_width,
          col_width_sm = content[[i]]$col_width_sm,
          css_height =  content[[i]]$css_height,
          row_height = content[[i]]$row_height,
          attribs = content[[i]]$attribs,
          shiny = shiny
        )
      } else {
        coltag <- build_knack(
          content = content[[i]],
          col_width = x$cols_width[i],
          col_width_sm = x$cols_width_sm[i],
          css_height =  heights[i],
          shiny = shiny
        )
      }
      tagAppendAttributes(coltag, class = paste0("grillade-", i))
    }
  )
  if (!is.null(x$max_n_col) && length(content) > x$max_n_col) {
    n_col <- x$max_n_col
  } else {
    n_col <- x$n_col
  }
  content <- tags$div(
    class = grid_class(n_col, x$n_col_sm),
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





