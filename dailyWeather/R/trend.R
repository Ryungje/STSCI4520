#' Estimating yearly trend of temperatures over time
#'
#' Retrieve yearly average temperature for each station, in degrees Celsius
#'
#' @param data data frame with NCEI station data
#' @return a data frame with following components:
#' # example code
#' @export
get_temp_trend <- function(data){
  # get first and last years
  first_year <- format(data$LST_DATE[1], "%Y") %>% as.numeric()
  last_year <- format(data$LST_DATE[length(data$LST_DATE)], "%Y") %>% as.numeric()

  # initialize data frame
  return <- matrix(NA, nrow = last_year - first_year + 1,
                   ncol = length(data$T_DAILY_AVG) + 1) %>% data.frame()

  # fill in column names and fill in year column
  names(return) <- c("Year", unique(data$Station_Name))
  return$Year <- first_year:last_year

  for (y in first_year:last_year){
    for (n in names(return)){
      # get yearly data
      start <- paste0(y, "0101") %>% as.Date("%Y%m%d")
      end <- paste0(y, "1231") %>% as.Date("Y%m%d")
      year_data <- get_time_series(data, "NC_Asheville_13_S", start, end)

      # convert any -9999 values to 0
      year_data$T_DAILY_AVG[which(year_data$T_DAILY_AVG == -9999)] <- 0

      # fill in data
      pos <- which(year_data$Year == y)
      return[[n]][pos] <- sum(year_data$T_DAILY_AVG) / length(year_data$T_DAILY_AVG)
      }
  }

  return(return)
}



