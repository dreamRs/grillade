
test_that("grid_class works", {
  expect_identical(grid_class(NULL), "autogrid")
  expect_identical(grid_class(3), "grid-3")
})


test_that("col_class works", {
  expect_identical(col_class(NULL), NULL)
  expect_identical(col_class(3), "col-3")
})


test_that("gutter_class works", {
  expect_identical(gutter_class(TRUE), "has-gutter")
  expect_identical(gutter_class("l"), "has-gutter-l")
  expect_identical(gutter_class("xl"), "has-gutter-xl")
  expect_identical(gutter_class("aaa"), NULL)
})
