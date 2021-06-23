#' Longest distance
#' @description Return the longest distance for a given ship
#' @param data dataframe containing at least the following columns : SHIPNAME, LAT, LON, DATETIME
#' @param shipname a string
#' @import dplyr
#' @examples 
#' longest_distance(ships, "KAROLI")
longest_distance <- function(data, shipname) {
  df <- data %>%
    filter(SHIPNAME == shipname) %>%
    arrange(DATETIME) %>%
    select(c("LAT", "LON", "DATETIME"))
  
  df_endpoint <- df %>%
    lag() %>%
    slice(-1) %>%
    rename(lat1 = LAT,
           long1 = LON,
           datetime1 = DATETIME)
  
  df_startpoint <- df %>%
    slice(-1) %>%
    rename(lat2 = LAT,
           long2 = LON,
           datetime2 = DATETIME)
  
  df_distances <- cbind(df_startpoint, df_endpoint)
  
  df_distances$distance <-
    do.call(haversine_dist,
            df_distances %>% select(long1, lat1, long2, lat2))
  
  return(df_distances %>%
           slice_max(distance, n = 1) %>%
           slice_max(datetime1, n = 1))
}


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

