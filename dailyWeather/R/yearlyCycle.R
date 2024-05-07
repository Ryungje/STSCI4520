#' Calculate and return the average daily temperatures for each day of the year for a specified weather station.
#'
#' @param data data frame with NCEI data
#' @param station station name
#' @returns A data frame
#' @examples
#' @export
get_yearly_cycle <- function(data, station_name) {
  library(dplyr)
  library(lubridate)
  library(tidyr)

  # Filter data for the specified station
  station_data <- data %>%
    filter(Station_Name == station_name)

  # Convert date and temperatures to appropriate types
  station_data$LST_DATE <- as.Date(station_data$LST_DATE)
  station_data$T_DAILY_MEAN <- as.numeric(as.character(station_data$T_DAILY_MEAN))

  # Remove placeholder values and handle missing data
  station_data <- station_data %>%
    mutate(T_DAILY_MEAN = ifelse(T_DAILY_MEAN == -9999.0, NA, T_DAILY_MEAN))

  # Group by day of the year and calculate mean temperature
  daily_means <- station_data %>%
    group_by(day_of_year = yday(LST_DATE)) %>%
    summarize(mean_temp = mean(T_DAILY_MEAN, na.rm = TRUE), .groups = 'drop')

  # Ensure output has 365 days, filling missing days with NA if necessary
  complete_daily_means <- data.frame(day_of_year = 1:365) %>%
    left_join(daily_means, by = "day_of_year") %>%
    replace_na(list(mean_temp = NA))

  return(complete_daily_means)
}
