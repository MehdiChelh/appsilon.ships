#' Distance between coordinate (Haversine method)
#' @description Calculate distance in meters between two coordinates (latitude, longitude).
#' @param long1 float, longitude of the first coordinate
#' @param lat1 float, latitude of the first coordinate
#' @param long2 float, longitude of the second coordinate
#' @param lat2 float, latitude of the second coordinate
#' @seealso https://www.movable-type.co.uk/scripts/latlong.html
haversine_dist <- function (long1, lat1, long2, lat2)
{
  # source : https://www.movable-type.co.uk/scripts/latlong.html
  R <- 6378000 # Earth radius
  deg_to_rad <- pi / 180
  # Conversion deg to radius
  lat1 <- lat1 * deg_to_rad
  long1 <- long1 * deg_to_rad
  lat2 <- lat2 * deg_to_rad
  long2 <- long2 * deg_to_rad
  # Calculation
  dlon <- long2 - long1
  dlat <- lat2 - lat1
  a <- sin(dlat / 2) ^ 2 + cos(lat1) * cos(lat2) * sin(dlon / 2) ^ 2
  c <- 2 * atan2(sqrt(a), sqrt(1 - a))
  
  return(R * c)
}

