#' Interpolate station data to a grid within the contiguous USA
#'
#' @param station_data A spatial dataframe containing station locations and the variable to interpolate.
#' @param variable_name The name of the variable in station_data to interpolate.
#' @param grid_points A spatial dataframe of grid points where data needs to be interpolated.
#' @param idw_power The power parameter for IDW interpolation, default is 2.
#' @returns A spatial dataframe of grid points with interpolated values.
#' @examples
#' stations <- st_as_sf(data.frame(longitude = c(-120, -122), latitude = c(36, 38), temp = c(15, 10)),
#'                      coords = c("longitude", "latitude"), crs = 4326)
#' grid <- create_usa_grid(resolution = 1)
#' interpolated_data <- interpolate_to_grid(stations, "temp", grid)
#' print(interpolated_data)
#' @export
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
}
