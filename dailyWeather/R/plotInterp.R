#' Plot the gridded interpolations on a map
#'
#' @param grid_data A dataframe of gridded interpolation points.
#' @param variable_name The name of the variable in data_stations to interpolate.
#' @returns An plot representing the interpolated data plotted over a map of the USA.
#' @examples
#' usa_grid <- create_usa_grid(resolution = 5)
#' interpolated_data <- interpolate_station_to_grid(data, points, "T_DAILY_AVG")
#' plot_gridded_interpolations(interpolated_data, 'T_DAILY_AVG')
#' print(plot_gridded_interpolations)
#' @export

library(ggplot2)
library(maps)

plot_gridded_interpolations <- function(grid_data, variable_name) {
  # Load USA map data
  usa_map <- map_data("state")
  
  # Create the base map
  base_map <- ggplot(data = usa_map, aes(x = long, y = lat, group = group)) +
    geom_polygon(fill = "gray90", color = "black") +
    coord_fixed(1.3) + 
    theme_minimal() +
    labs(title = paste("Interpolation of", variable_name, "across the USA"),
         x = "Longitude", y = "Latitude")
  
  # Overlay the gridded interpolations
  interpolation_plot <- base_map +
    geom_point(data = grid_data, aes(x = LONGITUDE, y = LATITUDE, color = !!sym(variable_name)),
               size = 2, alpha = 0.6) +
    scale_color_viridis_c(option = "C", begin = 0.3, end = 0.7, name = variable_name) +
    guides(color = guide_colorbar(title = variable_name))
  
  # Display the plot
  print(interpolation_plot)
}