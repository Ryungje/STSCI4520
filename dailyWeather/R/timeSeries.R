#' Retrieve data during a time series
#'
#' Get weather data for each day, unless given specific time series, for a given station.
#'
#' @param data data frame with NCEI data
#' @param station station name
#' @param start optional argument for start date, a Date object
#' @param end optional argument for end date, a Date object
#' @returns A data frame
#' @examples
#' # Using built in dataset
#' data <- dailyWeather::data
#' start <- as.Date("20010101","%Y%m%d")
#' end <- as.Date("20231231","%Y%m%d")
#' ex1 <- get_time_series(data, "NC_Asheville_13_S", start = start)
#' ex2 <- get_time_series(data, "NC_Asheville_13_S", end = end)
#' print(head(ex1$LST_DATE))
#' print(tail(ex2$LST_DATE))
#'
#' @export
get_time_series <- function(data, station, start=NULL, end=NULL){
  if (is.null(start) & is.null(end)){ #if given no optional arguments
    return <- data[which(data$Station_Name == station), ]
  }
  else if (!is.null(start) & is.null(end)){ #if given start date
    return <- data[which(data$Station_Name == station & data$LST_DATE >= start), ]
  }
  else if (is.null(start) & !is.null(end)){ #if given end date
    return <- data[which(data$Station_Name == station & data$LST_DATE <= end), ]
  }
  else{ #if given both arguments
    return <- data[which(data$Station_Name == station &
                           data$LST_DATE >= start &
                           data$LST_DATE <= end),
                   ]
  }

  return(return)
}
