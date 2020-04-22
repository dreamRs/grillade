
test_that("grillade works", {

  grll <- grillade(htmltools::tags$div(), htmltools::tags$div())

  expect_is(grll, "grillade")
  expect_length(grll$content, 2)
  expect_null(grll$dependencies)
  expect_null(grll$n_col)
})


test_that("grillade works with knack", {

  grll <- grillade(knack(), knack())

  expect_is(grll, "grillade")
  expect_length(grll$content, 2)
  expect_null(grll$dependencies)
  expect_null(grll$n_col)

  grll_b <- build_grillade(grll)
  expect_is(grll_b, "shiny.tag")
  expect_is(htmltools::findDependencies(grll_b), "list")
})


test_that("grillade works custom grid", {

  grll <- grillade(
    .list = list(
      htmltools::tags$div(), htmltools::tags$div()
    ),
    n_col = 5, cols_width = c(2, 3)
  )

  expect_is(grll, "grillade")
  expect_length(grll$content, 2)
  expect_null(grll$dependencies)
  expect_identical(grll$n_col, 5)
  expect_length(grll$cols_width, 2)
})


test_that("grillade works with htmlwidgets", {


  grll <- grillade(
    apexcharter::apexchart(),
    apexcharter::apexchart(),
    apexcharter::apexchart()
  )

  expect_is(grll, "grillade")
  expect_length(grll$content, 3)
  expect_true(!is.null(grll$dependencies))
  expect_null(grll$n_col)
})



test_that("build_grillade works", {

  grll <- grillade(htmltools::tags$div(), htmltools::tags$div())
  grll_b <- build_grillade(grll)

  expect_is(grll_b, "shiny.tag")
  expect_is(htmltools::findDependencies(grll_b), "list")
})


test_that("build_grillade works in shiny", {

  grll <- grillade(ggplot2::ggplot(), htmltools::tags$div())
  grll_b <- build_grillade(grll, shiny = TRUE)

  expect_is(grll_b, "shiny.tag")
  expect_is(htmltools::findDependencies(grll_b), "list")
})


test_that("knack works", {

  knk <- knack(htmltools::tags$div(), style = "style", cols = 2, rows = 3, cols_sm = 1)

  expect_is(knk, "knack")
  expect_length(knk$content, 1)
  expect_identical(knk$col_width, 2)
  expect_identical(knk$row_height, 3)
  expect_identical(knk$col_width_sm, 1)
  expect_is(knk$attribs, "list")


  expect_error(knack(cols_sm = 2))
})

test_that("build_knack works", {

  knackTag <- build_knack(
    content = htmltools::tags$div(),
    col_width = 2,
    col_width_sm = NULL,
    css_height =  NULL,
    row_height = 3,
    attribs = NULL,
    shiny = FALSE
  )

  expect_is(knackTag, "shiny.tag")
})
