library(dplyr)
library(readr)
library(stringr)


# Scan headers for col names
headers <- scan("headers.txt", what="character")
headers <- headers[29:56] #extract only relevant headers

# Initialize data
data <- matrix(ncol=30)

for (i in 2000:2024){
  # Get path for each folder year
  year_path <- file.path("CRND0103-202404080750", as.character(i))

  # Obtain .txt files in folder
  files <- list.files(year_path, full.names = TRUE, pattern = "\\.txt$")


  # Scan data in folder
  for (f in files){
    temp <- scan(f, what="character")

    # Extract file_name, aka station name, and state data
    file_name <- str_extract(basename(f), "(?<=-)[A-Z]+_[A-Za-z_]+\\d*_\\w+")
    state <- str_extract(file_name, "^[A-Z]+")

    # Collect data into matrix
    temp <- matrix(temp, byrow=TRUE, ncol=28)
    temp <- cbind(temp, file_name)
    temp <- cbind(temp, state)


    # Append temp to data
    if ( is.na(data[1]) ){
      data <- temp
    }else {
      data <- rbind(data, temp)
    }

  }

}


data <- data.frame(data)
names(data) <- c(headers, "Station_Name", "State")
data <- data[,!colnames(data) %in% headers[12:28]]

View(data)


