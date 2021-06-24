#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import leaflet
#' @import tidyr
#' @noRd
app_server <- function( input, output, session ) {
  # ---------------------------------------------
  # --- Modules
  # ---------------------------------------------
  selection <- mod_select_vessel_server("vessel_selection", ships)
  
  
  # ---------------------------------------------
  # --- Reactive
  # ---------------------------------------------
  
  # ------ longest_distance
  longest_dist <- reactive({
    req(selection$ship_name())
    
    ship_name <- selection$ship_name()
    
    ship_distance <- longest_distance(ships, ship_name)
    
    cbind(
      ship_distance %>% gather("step", "LAT", starts_with("lat")) %>% select(LAT),
      ship_distance %>% gather("step", "LON", starts_with("lon")) %>% select(LON),
      ship_distance %>% gather("step", "DATETIME", starts_with("datetime")) %>% select(c(DATETIME, distance))
    ) %>% arrange(DATETIME)
  })
  
  # ------- ship_data
  ship_data <- reactive({
    req(selection$ship_name())
    
    ship_name <- selection$ship_name()
    
    ships %>% filter(SHIPNAME == ship_name)
  })
  
  
  # ---------------------------------------------
  # --- Outputs
  # ---------------------------------------------
  
  # ------ Leaflet output
  output[["ship-map"]] <- renderLeaflet({
    req(longest_dist)
    
    longest_dist_df <- longest_dist()
    
    leaflet(longest_dist_df) %>%
      addProviderTiles(providers$Stamen.TonerLite,
                       options = providerTileOptions(noWrap = TRUE)
      ) %>%
      addAwesomeMarkers(lng = longest_dist_df$LON[2],
                        lat = longest_dist_df$LAT[2],
                        label=paste('Second Observation, ', longest_dist_df$DATETIME[2])) %>%
      addAwesomeMarkers(lng = longest_dist_df$LON[1],
                        lat = longest_dist_df$LAT[1],
                        label=paste('First Observation, ', longest_dist_df$DATETIME[1])) %>%
      addMeasure(primaryLengthUnit = "meters")
  })
  
  # ------ Text output : vessel_distance
  output[["vessel_distance"]] <- renderText({
    req(longest_dist)
    
    longest_dist_df <- longest_dist()
    
    paste(
      "The longest distance between two observations for this vessel is:",
      format(
        round(longest_dist_df$distance[1]),
        big.mark = ","
      ), "meters."
    )
  })
}
