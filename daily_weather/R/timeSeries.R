#' Retrieve data during a time series
#'
#' Get weather data for each day, unless given specific time series, for a given station.
#'
#' @param data data frame with NCEI data
#' @param station station name
#' @param start optional argument for start date
#' @param end optional argument for end date
#' @returns A data frame
#' @examples
#' @export
get_time_series <- function(data, station, start=NULL, end=NULL){
  return(data[which(data$Station_Name == station), ])
}
