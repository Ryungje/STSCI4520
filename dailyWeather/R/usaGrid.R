#' Create a grid of points that fall within the contiguous USA.
#'
#' @param resolution optional argument for controlling the resolution, defaults to 1
#' @returns A spatial dataframe containing the grid points within the contiguous USA.
#' @examples
#' grid <- create_usa_grid()
#' print(result)
#' plot(result)
#' grid05 <- create_usa_grid(resolution = 0.5)
#' print(result05)
#' plot(result05)
#' @export
create_usa_grid <- function(resolution = 1) {
  library(sf)
  library(GpGp)
  library(sp)
  library(ggplot2)
  # Load USA map data from ggplot2's built-in datasets
  usa_map <- ggplot2::map_data("usa", region = "main")

  # Create sequences for longitude and latitude based on the desired resolution
  long_range <- seq(from = min(usa_map$long), to = max(usa_map$long), by = resolution)
  lat_range <- seq(from = min(usa_map$lat), to = max(usa_map$lat), by = resolution)

  # Generate grid points
  grid_points <- expand.grid(lon = long_range, lat = lat_range)

  # Determine which grid points are within the USA using point-in-polygon test
  grid_points$in_usa <- sp::point.in.polygon(grid_points$lon, grid_points$lat,
                                             usa_map$long, usa_map$lat)

  # Filter grid points that are within the USA boundaries
  grid_usa <- grid_points[grid_points$in_usa != 0,]

  # Create a plot with USA map and overlay the grid points
  plot <- ggplot() +
    geom_polygon(data = usa_map, aes(x = long, y = lat), fill = "white", color = "black") +
    geom_point(data = grid_usa, aes(x = lon, y = lat),
               color = "red", size = 0.75) +
    coord_fixed(1.3) +
    ggtitle("Grid Overlay on USA Map")

  # Return both the grid and the plot
  return(list(grid = grid_usa, plot = plot))
}
