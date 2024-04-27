library(dplyr)
library(readr)
library(stringr)

base_path <- "../Project Dataset/CRND0103 Apr 8"

headers <- read_lines(file.path(base_path, "../Project Dataset/headers.txt"))

# Collect all data
all_data <- list()

for (year in 2000:2024) {
  # Define the path to the yearly sub-folder
  year_path <- file.path(base_path, as.character(year))
  
  # List all .txt files in the directory for the year
  files <- list.files(year_path, full.names = TRUE, pattern = "\\.txt$")
  
  for (file_path in files) {
    
    data <- read_table(file_path, col_names = FALSE, col_types = cols(.default = col_double()))
    
    # Rename the columns based on headers.txt
    names(data) <- headers
    
    # Extract state and station name from file name
    file_details <- str_extract(basename(file_path), "(?<=-)[A-Z]+_[A-Za-z_]+\\d*_\\w+")
    state <- str_extract(file_details, "^[A-Z]+")
    station_name <- str_extract(file_details, "[A-Za-z_]+\\d*_\\w+$")
    
    # Select only necessary columns
    selected_data <- data %>%
      select(WBANNO, LST_DATE, CRX_VN, LONGITUDE, LATITUDE, T_DAILY_MAX, T_DAILY_MIN, T_DAILY_MEAN, T_DAILY_AVG, P_DAILY_CALC, SOLARAD_DAILY) %>%
      mutate(
        State = state,
        StationName = station_name
      )
    
    # Append the data frame to the list
    all_data[[length(all_data) + 1]] <- selected_data
  }
}

# Combine all data frames into a single data frame
final_data <- bind_rows(all_data)

head(final_data)

write_csv(final_data, "complete_weather_data.csv")
