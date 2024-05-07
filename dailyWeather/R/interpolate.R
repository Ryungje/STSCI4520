#' Interpolate station data to a grid within the contiguous USA using different methods
#'
#' @param data_stations A dataframe containing station locations and the variable to interpolate.
#' @param grid A spatial dataframe of grid points where data needs to be interpolated.
#' @param var The name of the variable in data_stations to interpolate.
#' @param method The regression method used, defaults to Gaussian process (gp)
#' @returns A spatial dataframe of grid points with interpolated values.
#' @examples
#' usa_grid <- create_usa_grid(resolution = 5)
#' interpolated_data <- interpolate_station_to_grid(data, points, "T_DAILY_AVG")
#' print(interpolated_data)
#' @export
<<<<<<< HEAD

library(sf)
library(gstat)
library(GpGp)

# Function to interpolate station data onto a grid
interpolate_station_to_grid <- function(data_stations, grid, var) {
  # Remove missing data and obtain coordinates
  valid_data <- !is.na(data_stations[[var]])
  coordinates <- cbind(data_stations$LONGITUDE[valid_data], data_stations$LATITUDE[valid_data])
  
  # Construct covariates
  cov <- cbind(rep(1, times = sum(valid_data)), coordinates)
  
  # Fit the Gaussian process model
  gp_model <- GpGp::fit_model(y = data_stations[[var]][valid_data],
                              locs = coordinates, X = cov,
                              "matern_sphere", silent = TRUE)
  
  # Set up prediction locations
  prediction_locations <- cbind(grid$x, grid$y)
  cov_predict <- cbind(rep(1, nrow(prediction_locations)), prediction_locations)
  
  # Predict at grid locations
  predicted_values <- GpGp::predictions(fit = gp_model, locs_pred = prediction_locations,
                                        X_pred = cov_predict, m = nrow(prediction_locations))
  
  print(str(predicted_values))
  
  # Check that prediction and grid point counts match
  if (length(predicted_values) != nrow(grid)) {
    stop(paste("Number of predictions", length(predicted_values), 
               "does not match number of grid points", nrow(grid), "."))
  }
  
  # Create data frame with interpolated values
  interpolated_grid <- data.frame(LONGITUDE = grid$x,
                                  LATITUDE = grid$y,
                                  VALUE = predicted_values)
  
  # Update the column name to reflect the variable of interest
  names(interpolated_grid)[3] <- var
  
  return(interpolated_grid)
=======
interpolate_to_grid <- function(station_data, variable_name, grid_points, idw_power = 2) {
  library(sf)
  library(gstat)

  if (!requireNamespace("sf", quietly = TRUE) || !requireNamespace("gstat", quietly = TRUE)) {
    stop("Please install the 'sf' and 'gstat' packages to use this function.")
  }

  # Ensure the station data and grid points have the same CRS
  if (st_crs(station_data) != st_crs(grid_points)) {
    station_data <- st_transform(station_data, st_crs(grid_points))
  }

  # Prepare the IDW model using gstat
  idw_model <- gstat::gstat(formula = as.formula(paste(variable_name, "~ 1")),
                            locations = ~longitude+latitude, data = station_data,
                            nmax = 7, set = list(idp = idw_power))

  # Perform the interpolation over the grid
  interpolated_values <- predict(idw_model, newdata = grid_points, type = "interp")

  return(interpolated_values)
>>>>>>> 4e8198b5763570d77d37f191d4500b3e38e134b0
}
