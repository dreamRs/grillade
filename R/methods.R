
#' Print method for grillade/knack objects
#'
#' @param x A \code{\link{grillade}} or \code{\link{knack}} object.
#' @param ... Additional arguments.
#'
#' @name print-methods
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
        build_grillade(x),
        style = "width: 100%; height: 100%;",
        class = "viewer-grillade-ouptut"
      )
    )
  )
  print(browsable(TAG))
}

#' @rdname print-methods
#' @export
print.knack <- function(x, ...) {
  TAG <- build_knack(
    content = x$content,
    col_width = x$col_width,
    col_width_sm = x$col_width_sm,
    css_height =  x$css_height,
    row_height = x$row_height,
    attribs = x$attribs
  )
  print(TAG)
}



knit_print.grillade <- function(x, ..., options = NULL) {
  TAG <- tagAppendAttributes(
    build_grillade(x, knitr = TRUE),
    class = "knitr-grillade-ouptut"
  )
  class(TAG) <- setdiff(class(TAG), "grillade")
  knitr::knit_print(browsable(TAG), options = options, ...)
}


#' @method as.tags grillade
#' @importFrom htmltools as.tags
#' @export
as.tags.grillade <- function(x, ...) {
  build_grillade(x)
}



