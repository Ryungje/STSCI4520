library(testthat)

test_that("interpolate_station_to_grid basic functionality", {
  data_stations <- dailyWeather::data
  grid <- dailyWeather::create_usa_grid()
  
  # Expected to run without error and produce interpolated values
  result <- interpolate_station_to_grid(data_stations, grid, "T_DAILY_AVG")
  
  expect_equal(nrow(result), 2)
  expect_true(all(names(result) == c("LONGITUDE", "LATITUDE", "T_DAILY_AVG")))
})

test_that("interpolate_station_to_grid handles missing data", {
  data_stations <- dailyWeather::data
  grid <- dailyWeather::create_usa_grid()
  
  result <- interpolate_station_to_grid(data_stations, grid, "T_DAILY_AVG")
  expect_true(is.na(result$T_DAILY_AVG))
})

test_that("interpolate_station_to_grid handles empty inputs", {
  empty_data <- data.frame(
    LONGITUDE = numeric(),
    LATITUDE = numeric(),
    T_DAILY_AVG = numeric()
  )
  
  grid <- data.frame(
    x = numeric(),
    y = numeric()
  )
  
  expect_error(interpolate_station_to_grid(empty_data, grid, "T_DAILY_AVG"),
               "data frame with 0 columns and 0 rows")
})

test_that("interpolate_station_to_grid error handling for invalid variable", {
  data_stations <- dailyWeather::data
  grid <- dailyWeather::create_usa_grid()
  
  expect_error(interpolate_station_to_grid(data_stations, grid, "INVALID_VAR"),
               "variable not found in data_stations")
})
