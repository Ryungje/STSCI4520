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

    if (is.na(file_name)){
      file_name <- "MT_St._Mary_1_SSW"
      state <- "MT"
    }
    # Collect data into matrix
    temp <- matrix(temp, byrow=TRUE, ncol=28)
    temp <- cbind(temp, file_name) #attach station_name and state
    temp <- cbind(temp, state)

    # Append temp to data
    if ( is.na(data[1]) ){
      data <- temp
    }else {
      data <- rbind(data, temp)
    }

  }

}


# Convert to data frame
data <- data.frame(data)

# Update col names
names(data) <- c(headers, "Station_Name", "State")

# Remove unnecessary columns
data <- data[,!colnames(data) %in% headers[12:28]]

# Convert LST_DATE to Date Object
data$LST_DATE <- as.Date(data$LST_DATE, "%Y%m%d")

# Convert relevant columns into numerics
for (i in names(data)[-c(2,12,13)]){
  data[[i]] <- as.numeric(data[[i]])
}

# fill in missing data
#for (i in which(is.na(data$Station_Name))){
#  data$Station_Name[i] <- "MT_St._Mary_1_SSW"
#  data$State[i] <- "MT"
#}

# Save data
#write.csv(data, file="Daily_Dataset.csv")
save(data, file="Daily_Dataset.RData")

# Load data
#load("Daily_Dataset.RData")


