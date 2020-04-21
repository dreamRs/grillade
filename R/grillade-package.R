#' @title Grid System for the Web
#'
#' @description Grid sytem for 'shiny' applications or 'rmarkdown'
#'  document and to create 'htmlwidgets' matrix.
#'
#' @section Shiny:
#' \code{\link{grillade}} can be used in UI but also in server with
#'  \code{grilladeOutput}/\code{renderGrillade}.
#'
#' @section Markdown:
#' \code{\link{grillade}} can be used directly in a markdown document with
#'  \code{htmlwidget}s or HTML tags or with Pandoc's fenced div: \code{\:\:\:\:} and normal chunks.
#'
#' @note CSS code used by \code{grillade} is from \href{https://www.knacss.com/doc.html#grids}{KNACSS}.
#'
#' @name grillade-package
#' @docType package
#' @author Victor Perrier (@@dreamRs_fr)
NULL

#' grillade exported operators and S3 methods
#'
#' The following functions are imported and then re-exported
#' from the grillade package.
#'
#' @name grillade-exports
NULL

#' @importFrom htmltools tags
#' @name tags
#' @export
#' @rdname grillade-exports
NULL

#' @importFrom htmltools tagList
#' @name tagList
#' @export
#' @rdname grillade-exports
NULL
