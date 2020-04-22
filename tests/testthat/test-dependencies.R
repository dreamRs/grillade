
test_that("use_grillade works", {

  dep <- use_grillade()

  expect_is(dep, "shiny.tag")
  expect_is(htmltools::findDependencies(dep), "list")
})
