#' Interpolate station data to a grid within the contiguous USA
#'
#' @param station_data A spatial dataframe containing station locations and the variable to interpolate.
#' @param date_to_predict The date to predict
#' @param variable The target variable
#' @returns A spatial dataframe of grid points with interpolated values.
#' @examples
#' stations <- st_as_sf(data.frame(longitude = c(-120, -122), latitude = c(36, 38), temp = c(15, 10)),
#'                      coords = c("longitude", "latitude"), crs = 4326)
#' grid <- create_usa_grid(resolution = 1)
#' interpolated_data <- interpolate_to_grid(stations, "temp", grid)
#' print(interpolated_data)
#' @export
interpolate_to_grid <- function(data, data_to_predict, variable){
  #Locations

  available_data <- !is.na(data[variable])
  locs <- cbind(data$LONGITUDE[available_data], data$LATITUDE[available_data])

  #Covariates
  X <- cbind(rep(1, times = sum(available_data)), locs)
  gpfit_model <- GpGp::fit_model(y = data["T_DAILY_AVG"][available_data,],
                                 locs = locs, X = X,
                                 "matern_sphere", silent = TRUE)

  pred_inds <- data_to_predict
  locs_pred <- as.matrix(cbind(pred_inds[,1], pred_inds[,2]))
  X_pred <- cbind(rep(1, nrow(locs_pred)), locs_pred)
  prediction_data <- GpGp::predictions(fit = gpfit_model, locs_pred = locs_pred,
                                       X_pred = X_pred, m = 30)

  interpolated <- data.frame(LONGITUDE = data_to_predict[,1],
                             LATITUDE = data_to_predict[,2],
                             VALUE = prediction_data)

  names(interpolated)[3] <- variable

  return(interpolated)
}
