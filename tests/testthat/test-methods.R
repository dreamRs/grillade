
test_that("as.tags.grillade works", {
  expect_is(htmltools::as.tags(grillade()), "shiny.tag")
})

test_that("print.grillade works", {
  out <- capture.output(p <- print(grillade(), browsable = FALSE))
  expect_is(p, "shiny.tag")
})

test_that("print.knack works", {
  out <- capture.output(p <- print(knack()))
  expect_is(p, "shiny.tag")
})
