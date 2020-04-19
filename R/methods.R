
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
        build_grillade(x),
        style = "width: 100%; height: 100%;",
        class = "viewer-grillade-ouptut"
      )
    )
  )
  print(browsable(TAG))
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



