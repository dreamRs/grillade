#' Shiny resource
#'
#' @importFrom shiny addResourcePath
#'
#' @noRd
.onLoad <- function(...) {
  shiny::addResourcePath("grillade", system.file("assets", package = "grillade"))
  register_s3_method("knitr", "knit_print", "grillade")
}
