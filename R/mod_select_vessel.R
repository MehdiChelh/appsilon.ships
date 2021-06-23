#' select_vessel UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_select_vessel_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' select_vessel Server Functions
#'
#' @noRd 
mod_select_vessel_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_select_vessel_ui("select_vessel_ui_1")
    
## To be copied in the server
# mod_select_vessel_server("select_vessel_ui_1")
