# STSCI 4520
Final Project for STSCI 4520 - Statistical Computing (Cornell University, Spring 2024)


Personal Project Notes

(for information on dataset) https://www.ncei.noaa.gov/pub/data/uscrn/products/daily01/

  create_dataset.R Notes
  
  Point 3
  - Recycled ex04 code for extracting information from weather dataset
  - Then need to add code to extract station name and state from file name itself
    - Starting with one file, then expanding to loop through entire dataset
  - 
  
  Point 4
  - Assuming 'time series' will be another dataframe with the desired station's information (with optional parameters to indicate a specific time frame)
  
  Point 5
  - Don't think we are doing any calculations, just returning the observed temperature for a given day
  - Function will take in a year, and station, and give the average temperature for each day recorded
  - Temperature will be extracted from T_DAILY_AVG (not sure what difference is from T_DAILY_MEAN, however)
  
  Point 6
  - Maybe make a graph




