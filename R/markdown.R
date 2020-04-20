
html_grillade <- function(max_width = "100%", ...) {
  grlldep <- html_dependency_grillade()
  grlldep$head <- sprintf(
    "<style>.main-container {max-width: %s !important;}</style>",
    htmltools::validateCssUnit(max_width)
  )
  grlldep$stylesheet <- c(
    grlldep$stylesheet,
    "grillade-rmd.css"
  )
  rmarkdown::html_document(
    extra_dependencies = list(grlldep),
    ...
  )
}
