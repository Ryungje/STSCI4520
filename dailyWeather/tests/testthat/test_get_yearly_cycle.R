
test_that("yearly cycle computation for specific station", {
  
  data <- dailyWeather::data
  
  # basic functionality of the function
  test1 <- get_yearly_cycle(data, "NC_Asheville_13_S")
  expect_equal(
    nrow(test1),
    365
  )
  expect_true(all(test1$day_of_year == 1:365))
  expect_true(is.numeric(test1$mean_temp))
  
  # station name that does not exist in the dataset
  test2 <- get_yearly_cycle(data, "NC_Asheville_133_S")
  expect_equal(
    sum(is.na(test2$mean_temp)),
    365
  )
  
  # station having all missing data
  fake_data <- data
  fake_data$Station_Name <- "All_Missing_Station"
  fake_data$T_DAILY_MEAN <- as.character(rep(-9999.0, nrow(fake_data)))
  test3 <- get_yearly_cycle(fake_data, "All_Missing_Station")
  expect_equal(
    sum(is.na(test3$mean_temp)),
    365
  )
  
  # data that includes a leap year
  leap_year_data <- data
  leap_year_data$LST_DATE <- as.Date(c("2020-02-29", leap_year_data$LST_DATE))
  leap_year_data$T_DAILY_MEAN <- as.character(c(-9999.0, leap_year_data$T_DAILY_MEAN))
  leap_year_data$Station_Name <- c("NC_Asheville_13_S", leap_year_data$Station_Name)
  test4 <- get_yearly_cycle(leap_year_data, "NC_Asheville_13_S")
  expect_equal(
    nrow(test4),
    365
  )
  expect_false(any(test4$day_of_year == 366))
})