<h1>STSCI 4520 Personal Project Notes</h1>
Final Project for STSCI 4520 - Statistical Computing (Cornell University, Spring 2024)
<br>
<br>
<br>
<i>Using Weather Data from https://www.ncei.noaa.gov/pub/data/uscrn/products/daily01/ </i>
<br>
<h3>create_dataset.R</h3>
  
  <b>Point 3</b> <br>
  - Recycled ex04 code for extracting information from weather dataset <br>
  - Then need to add code to extract station name and state from file name itself <br>
    - Starting with one file, then expanding to loop through entire dataset
  - Finished data scraping script, create_data.R
  - Saved dataset as Daily_Dataset.RData (and .csv) for future use
<br>  
<br>
  <b>Point 4</b> <br>
  - Assuming 'time series' will be another dataframe with the desired station's information (with optional parameters to indicate a specific time frame)
  - Unclear what 'station id' means, will assume it's the station name
<br>
<br>
  <b>Point 5</b> <br>
  - Don't think we are doing any calculations, just returning the observed temperature for a given day <br>
  - Function will take in a year, and station, and give the average temperature for each day recorded <br>
  - Temperature will be extracted from T_DAILY_AVG (not sure what difference is from T_DAILY_MEAN, however)
<br>  
<br>
  <b>Point 6</b> <br>
  - Maybe make a graph? Or just another dataframe filled with yearly temperature data for the station <br>
  - Either way, need to calculate the yearly average temperature for one station<br>
    - Going to use T_DAILY_AVG like before
<br>
<br>
  <b>Point 7</b> <br>
  - Using longitude and latitude data <br>
  - Extract coordinates of each station (station doesn't move haha so no need to keep updating for same station) <br>
  - Only using points that fall within the mainland USA <br>
  - Not sure how the resolution and polygon stuff will be important
<br>
<br>
  <b>Point 8</b> <br>
  - No idea <br>
  - Probably have to figure out what a grid point is first
<br>   
<br>
  <b>Point 9</b> <br>
  - <br>
  




