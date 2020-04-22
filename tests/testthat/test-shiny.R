
test_that("grilladeOutput works", {

  TAG <- grilladeOutput("ID")

  expect_is(TAG, "shiny.tag")
  expect_is(htmltools::findDependencies(TAG), "list")
})

test_that("renderGrillade works", {

  expect_null(renderGrillade(NULL)())
  expect_error(renderGrillade("a")())

  rendered <- renderGrillade(grillade())()

  expect_is(rendered, "list")
  expect_is(rendered$content, "list")


  rendered <- renderGrillade(list("a", "b"))()

  expect_is(rendered, "list")
  expect_is(rendered$content, "list")
})

