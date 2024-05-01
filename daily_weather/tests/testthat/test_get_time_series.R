
test_that( "time series looks good", {

  data <- daily_weather::data

  # with no optional arguments
  test1 <- get_time_series(data, "NC_Asheville_13_S")
  expect_equal(
    length(test$WBANNO),
    8546
  )

  # with start input
  start <- as.Date("20010101", "%Y%m%d")
  test2 <- get_time_series(data, "NC_Asheville_13_S", start=start)
  expect_equal(
    length(test$WBANNO),
    8546
  )

  # With end input
  end <- as.Date("20011212", "%Y%m%d")
  test3 <- get_time_series(data, "NC_Asheville_13_S", end=end)
  expect_equal(
    length(test$WBANNO),
    8546
  )

  # With both start and end
  test3 <- get_time_series(data, "NC_Asheville_13_S", start=start, end=end)
  expect_equal(
    length(test$WBANNO),
    8546
  )
})


