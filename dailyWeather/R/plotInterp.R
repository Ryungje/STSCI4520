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

# Example usage:
# plot_gridded_interpolations(interpolated_data, 'T_DAILY_AVG')
