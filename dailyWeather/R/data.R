#' Daily weather data
#'
#' A data frame with daily weather data from 2000-2024
#'
#' @format a dataframe with 13 columns
#' \describe{
#'     \item{WBANN}{Station's WBAN Code}
#'     \item{LST_DATE}{The date of the observation, as Date object}
#'     \item{CRX_VIN}{The version number of the station datalogger}
#'     \item{LONGITUDE}{Station longitude}
#'     \item{LATITUDE}{Station latitude}
#'     \item{T_DAILY_MAX}{Maximum air temperature}
#'     \item{T_DAILY_MIN}{Minimum air temperature}
#'     \item{T_DAILY_MEAN}{Mean air temperature, in degrees C}
#'     \item{T_DAILY_AVG}{Average air temperature, in degrees C}
#'     \item{P_DAILY_CALC}{Total amount of precipitation, in mm}
#'     \item{SOLARAD_DAILY}{Total solar energy, in MJ/meter^2}
#'     \item{Station_Name}{Station name}
#'     \item{State}{Station's state}
#' }
"data"
