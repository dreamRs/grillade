
grid_class <- function(x, small = NULL) {
  if (is.null(x))
    return("autogrid")
  x <- paste("grid", x, sep = "-")
  if (!is.null(small))
    x <- paste0(x, "-small-", small)
  return(x)
}

col_class <- function(x, small = NULL) {
  if (is.null(x) || is.na(x))
    return(NULL)
  x <- paste("col", x, sep = "-")
  if (!is.null(small) && !is.na(small))
    x <- paste0(x, "-small-", small)
  return(x)
}

row_class <- function(x) {
  if (is.null(x) || is.na(x))
    return(NULL)
  paste("row", x, sep = "-")
}

gutter_class <- function(x) {
  if (isTRUE(x))
    return("has-gutter")
  if (identical(x, "l"))
    return("has-gutter-l")
  if (identical(x, "xl"))
    return("has-gutter-xl")
  return(NULL)
}


#' @importFrom shiny getDefaultReactiveDomain
is_shiny <- function() {
  !is.null(getDefaultReactiveDomain())
}

is_widget <- function(x) {
  inherits(x, "htmlwidget")
}
# extract2 <- function(x, nm) {
#   `[[`(x, nm)
# }
# @importFrom htmltools findDependencies
# is_widget <- function(x) {
#   deps <- vapply(
#     X = findDependencies(x),
#     FUN = extract2, nm = "name",
#     FUN.VALUE = character(1)
#   )
#   isTRUE("htmlwidgets" %in% deps)
# }


is_ggplot <- function(x) {
  inherits(x, "ggplot")
}

is_tag <- function(x) {
  inherits(x, c("shiny.tag", "shiny.tag.list"))
}

is_widgets <- function(x) {
  vapply(
    X = x,
    FUN = is_widget,
    FUN.VALUE = logical(1),
    USE.NAMES = FALSE
  )
}

is_ggplots <- function(x) {
  vapply(
    X = x,
    FUN = is_ggplot,
    FUN.VALUE = logical(1),
    USE.NAMES = FALSE
  )
}


#' @importFrom htmlwidgets shinyRenderWidget shinyWidgetOutput
makeRender <- function(widget, height = "400px") {
  widget <- force(widget)
  height <- force(height)
  name <- attr(widget, "class")[1]
  package <- attr(widget, "package")
  shinyRenderWidget(widget, function(outputId) {
    shinyWidgetOutput(
      outputId = outputId,
      name = name,
      width = "100%",
      height = height,
      package = package
    )
  }, parent.frame(), quoted = TRUE)
}



get_height <- function(x, knitr = FALSE) {
  if (is_widget(x)) {
    if (!is.null(x$height))
      return(x$height)
    if (isTRUE(knitr) & !is.null(x$sizingPolicy$knitr$defaultHeight))
      return(x$sizingPolicy$knitr$defaultHeight)
    return(NA_character_)
  } else if (inherits(x, "knack") && length(x$content) > 0) {
    get_height(x$content[[1]], knitr = knitr)
  } else {
    return(NA_character_)
  }
}
get_heights <- function(x, knitr = FALSE) {
  vapply(
    X = x,
    FUN = get_height, knitr = knitr,
    FUN.VALUE = character(1),
    USE.NAMES = FALSE
  )
}




# From vignette('knit_print', package = 'knitr')
# and https://github.com/rstudio/htmltools/pull/108/files

register_s3_method <- function(pkg, generic, class, fun = NULL) { # nocov start
  stopifnot(is.character(pkg), length(pkg) == 1)
  stopifnot(is.character(generic), length(generic) == 1)
  stopifnot(is.character(class), length(class) == 1)

  if (is.null(fun)) {
    fun <- get(paste0(generic, ".", class), envir = parent.frame())
  } else {
    stopifnot(is.function(fun))
  }

  if (pkg %in% loadedNamespaces()) {
    registerS3method(generic, class, fun, envir = asNamespace(pkg))
  }

  # Always register hook in case package is later unloaded & reloaded
  setHook(
    packageEvent(pkg, "onLoad"),
    function(...) {
      registerS3method(generic, class, fun, envir = asNamespace(pkg))
    }
  )
} # nocov end
