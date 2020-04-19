


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





