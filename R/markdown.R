
html_grillade <- function(max_width = "1280px", ...) {
  grlldep <- html_dependency_grillade()
  grlldep$head <- sprintf(
    "<style>.main-container {max-width: %s;}</style>",
    htmltools::validateCssUnit(max_width)
  )
  rmarkdown::html_document_base(
    # theme = NULL,
    extra_dependencies = list(grlldep),
    ...
  )
}
