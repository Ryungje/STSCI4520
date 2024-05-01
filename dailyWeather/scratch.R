#install.packages("devtools")
#install.packages("daily_weather")


dev <- function(){
  devtools::load_all() #to load in package
  #devtools::document() #to load in function documentation
  devtools::test() #run tests
  #devtools::run_examples() #run examples in documentations
  #devtools::check() #build package (?)
}

dev()



