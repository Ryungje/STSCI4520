#' Create a grid of points that fall within the contiguous USA.
#'
#' @param resolution optional argument for controlling the resolution, defaults to 1
#' @returns A spatial dataframe containing the grid points within the contiguous USA.
#' @examples
<<<<<<< HEAD
#' grid <- create_usa_grid()
#' print(result)
#' plot(result)
#' grid05 <- create_usa_grid(resolution = 0.5)
#' print(result05)
#' plot(result05)
#' @export

library(sf)
library(GpGp)
library(sp)
library(ggplot2)

# Function to create a grid overlaying the USA map at specified resolution
create_usa_grid <- function(resolution = 1) {
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
=======
#'
#' result <- create_usa_grid()
#' print(result)
#' plot(result)
#' dev.off()
#' result05 <- create_usa_grid(resolution = 0.5)
#' print(result05)
#' plot(result05)
#' @export
create_usa_grid <- function(resolution = 1) {
  library(sf)
  library(maps)
  # Load USA map data
  usa_map <- maps::map("usa", plot = FALSE, fill = TRUE)
  usa_sf <- st_as_sf(usa_map)

  # Focus on the contiguous USA by excluding Alaska, Hawaii, and territories
  sf_use_s2(FALSE)
  contiguous_usa <- usa_sf[!usa_sf$ID %in% c("alaska", "hawaii", "puerto rico"), ]

  # Simplify geometry to avoid potential issues with complex shapes
  contiguous_usa <- st_simplify(contiguous_usa, dTolerance = 0.01)

  # Create bounding box around contiguous USA
  bbox <- st_bbox(contiguous_usa)

  # Create grid points
  grid_points <- expand.grid(
    x = seq(from = bbox["xmin"], to = bbox["xmax"], by = resolution),
    y = seq(from = bbox["ymin"], to = bbox["ymax"], by = resolution)
  )
  points_sf <- st_as_sf(grid_points, coords = c("x", "y"), crs = st_crs(usa_sf))

  # Filter points to only those within the contiguous USA borders
  points_in_usa <- st_intersection(points_sf, contiguous_usa)

  return(points_in_usa)
}
>>>>>>> 4e8198b5763570d77d37f191d4500b3e38e134b0
