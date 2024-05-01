
test_that( "time series looks good", {

  test <- get_time_series(test_data, "NC_Asheville_13_S")

  expect_equal(
    length(test$WBANNO),
    8546
  )

})
