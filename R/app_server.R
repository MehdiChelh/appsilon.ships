#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # ---------------------------------------------
  # --- Modules
  # ---------------------------------------------
  selection <- mod_select_vessel_server("vessel_selection", ships)
}
