#' Estimating yearly trend of temperatures over time
#'
#' Retrieve yearly average temperature for a given station, in degrees Celsius
#'
#' @param data data frame with NCEI station data
#' @param station name of station
#' @return a data frame with following components:
#' # example code
#' @export
get_temp_trend <- function(data, station){
  # get first and last years
  first_year <- format(data$LST_DATE[1], "%Y") %>% as.numeric()
  last_year <- format(data$LST_DATE[length(data$LST_DATE)], "%Y") %>% as.numeric()

  # initialize data frame
  return <- matrix(NA, nrow = last_year - first_year + 1,
                   ncol = 2) %>% data.frame()

  # fill in column names and fill in year column
  names(return) <- c("Year", "Temp")
  return$Year <- first_year:last_year

  i <- 1
  #Obtain yearly trend data
  for (y in first_year:last_year){
    start <- paste0(y, "0101") %>% as.Date("%Y%m%d")
    end <- paste0(y, "1231") %>% as.Date("%Y%m%d")

    # get yearly data
    year_data <- get_time_series(data, station, start, end)

    # convert any -9999 values to 0
    year_data$T_DAILY_AVG[which(year_data$T_DAILY_AVG == -9999)] <- 0

    return$Temp[i] <- sum(year_data$T_DAILY_AVG) / length(year_data$T_DAILY_AVG)

    i <- i + 1
  }

  return(return)
}



