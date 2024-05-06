#install.packages("devtools")
install.packages("daily_weather")
library("devtools")
data <- dailyWeather::data

dev <- function(){
  #devtools::load_all() #to load in package
  #devtools::document() #to load in function documentation
  devtools::test() #run tests
  #devtools::run_examples() #run examples in documentations
  #devtools::check() #build package (?)
}

dev()


temp <- get_temp_trend(data, "NC_Asheville_13_S")
