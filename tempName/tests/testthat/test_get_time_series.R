
test_that( "time series looks good", {

  data <- daily_weather::data
  test <- get_time_series(data, "NC_Asheville_13_S")

  expect_equal(
    length(test$WBANNO),
    8546
  )

})
