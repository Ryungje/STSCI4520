
test_that( "time series", {

  data <- daily_weather::data

  # with no optional arguments
  test1 <- get_time_series(data, "NC_Asheville_13_S")
  expect_equal(
    length(test1$WBANNO),
    8546
  )

  # with start input
  start <- as.Date("20010101", "%Y%m%d")
  test2 <- get_time_series(data, "NC_Asheville_13_S", start=start)
  expect_equal(
    length(test2$WBANNO),
    8498
  )

  # With end input
  end <- as.Date("20231231", "%Y%m%d")
  test3 <- get_time_series(data, "NC_Asheville_13_S", end=end)
  expect_equal(
    length(test3$WBANNO),
    8448
  )

  # With both start and end
  test4 <- get_time_series(data, "NC_Asheville_13_S", start=start, end=end)
  expect_equal(
    length(test4$WBANNO),
    8400
  )
})


