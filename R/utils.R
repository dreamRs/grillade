
grid_class <- function(x, class) {
  if (is.null(x) && identical(class, "grid"))
    return("autogrid")
  stopifnot(length(x) == 1)
  if (is.na(x))
    return(NULL)
  paste(class, x, sep = "-")
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


