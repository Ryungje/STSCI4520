#' Estimating yearly trend of temperatures over time
#'
#' Retrieve yearly average temperature for each station, in degrees Celsius
#'
#' @param data data frame with NCEI station data
#' @return a data frame with following components:
#' # example code
#' @export
get_temp_trend <- function(data){
  return <- data.frame()

  return(return)
}

# get first and last years in data
first_year <- format(data$LST_DATE[1], "%Y")
last_year <- format(data$LST_DATE[length(data$LST_DATE)], "%Y")


matrix(NA,nrow=as.numeric(first_year)-as.numeric(last_year)+1, ncol=length())
