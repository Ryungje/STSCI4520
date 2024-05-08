library(testthat)
library(ggplot2)

test_that("plot_gridded_interpolations creates a plot", {
  grid_data <- dailyWeather::interpolate_station_to_grid(data, points, "T_DAILY_AVG")
  
  plot <- plot_gridded_interpolations(grid_data, "T_DAILY_AVG")
  expect_is(plot, "ggplot")
})

test_that("plot_gridded_interpolations handles empty data", {
  empty_data <- data.frame(
    LONGITUDE = numeric(),
    LATITUDE = numeric(),
    T_DAILY_AVG = numeric()
  )
  
  plot <- plot_gridded_interpolations(empty_data, "T_DAILY_AVG")
  expect_is(plot, "ggplot")
  # Checking that no points are plotted
  expect_equal(length(ggplot_build(plot)$data[[2]]$x), 0)
})

test_that("plot_gridded_interpolations handles non-data frame inputs", {
  expect_error(plot_gridded_interpolations(NULL, "T_DAILY_AVG"),
               "data must be a data.frame")
})

test_that("plot_gridded_interpolations includes necessary elements", {
  grid_data <- dailyWeather::interpolate_station_to_grid(data, points, "T_DAILY_AVG")
  
  plot <- plot_gridded_interpolations(grid_data, "T_DAILY_AVG")
  
  # Check that the plot includes a title and color bar
  plot_build <- ggplot_build(plot)
  expect_true("Interpolation of T_DAILY_AVG across the USA" %in% plot_build$layout$panel_params[[1]]$title)
  expect_true("guide-colourbar" %in% class(plot_build$guides$colour))
})
