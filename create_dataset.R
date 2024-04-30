

for (i in 2000:2024){
  # Get path for each folder year
  year_path <- file.path("CRND0103-202404080750", as.character(2000)) 
  #UPDATE YEAR USING LOOP
  
  # Obtain .txt files in folder
  files <- list.files(year_path, full.names = TRUE, pattern = "\\.txt$") 
  
  # Scan data and headers
  data <- scan(files[1], what="character")
  headers <- scan("headers.txt", what="character")
  
  headers <- headers[29:56] #extract only relevant headers
  
  # Create dataframe, while converting data into numerics
  data <- data.frame(matrix( as.numeric(unlist(data) ), ncol=length(headers), byrow = TRUE))
  names(data) <- headers
  
  data <- data[-c(12:28)] # remove unnecessary columns
  
}



head(data)


