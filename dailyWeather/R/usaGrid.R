#' Create a grid of points that fall within the contiguous USA.
#'
#' @param resolution optional argument for controlling the resolution, defaults to 1
#' @returns A spatial dataframe containing the grid points within the contiguous USA.
#' @examples
#' result <- create_usa_grid()
#' print(result)
#' plot(result)
#' result05 <- create_usa_grid(resolution = 0.5)
#' print(result05)
#' plot(result05)
#' @export

library(sf)
library(maps)

create_usa_grid <- function(resolution = 1) {
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
