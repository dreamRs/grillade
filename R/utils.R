
grid_class <- function(x, class) {
  if (is.null(x) && identical(class, "grid"))
    return("autogrid")
  stopifnot(length(x) == 1)
  if (is.na(x))
    return(NULL)
  paste(class, x, sep = "-")
}


