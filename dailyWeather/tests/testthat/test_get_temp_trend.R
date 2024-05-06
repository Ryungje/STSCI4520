
test_that( "time series", {

  data <- dailyWeather::data

  # basic functionality of the function
  test1 <- get_temp_trend(data, "NC_Asheville_13_S")
  expect_equal(
    nrow(test1),
    25
  )
  expect_true(all(test1$Year == 2000:2024))
  expect_true(is.numeric(test1$Temp))

  test2 <- test1
  expect_equal(
    test2$Temp[1],
    0
  )


})


