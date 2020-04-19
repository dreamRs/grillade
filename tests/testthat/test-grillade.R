
test_that("grillade works", {

  grll <- grillade(htmltools::tags$div(), htmltools::tags$div())

  expect_is(grll, "grillade")
  expect_length(grll$content, 2)
  expect_null(grll$dependencies)
  expect_null(grll$n_col)
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




