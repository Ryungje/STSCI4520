#install.packages("devtools")
#install.packages("daily_weather")
library("devtools")

dev <- function(){
  devtools::load_all() #to load in package
  #devtools::document() #to load in function documentation
  devtools::test() #run tests
  #devtools::run_examples() #run examples in documentations
  #devtools::check() #build package (?)
}

dev()

#data <- dailyWeather::data


# get latest year
data$LST_DATE[length(data$LST_DATE)]

y <- get_yearly_cycle(data,"NC_Asheville_13_S")

