library(testthat)

test_that( "create grid of points", {

  test1 <- create_usa_grid()
  expect_equal(
    class(test1)[1],
    "list"
  )

  test2 <- create_usa_grid(4)
  expect_equal(
    length(test1$geometry) > length(test2$geometry),
    FALSE
  )

})
