#' select_vessel UI Function
#'
#' @description A shiny Module. A dropdown menu for selecting your vessel. "data" should have the following fields : "SHIPNAME", "ship_type".
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_select_vessel_ui <- function(id){
  ns <- NS(id)
  tags$div(class = "ui large form",
           tags$div(
             class = "two fields",
             tags$div(class = "field",
                      tags$label("Ship Type"),
                      dropdown_input(ns("ship_type"), "Ship Type", value = NULL, type="selection fluid search")),
             tags$div(class = "field",
                      tags$label("Ship Name"),
                      dropdown_input(ns("ship_name"), "Ship Name", value = NULL, type="selection fluid search"))
           ))
}
    
#' select_vessel Server Functions
#'
#' @noRd 
mod_select_vessel_server <- function(id, data){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    # ----- Ship type
    ship_type_choices <- levels(factor(data$ship_type)) # ship_type is supposed to be a factor but I added
    update_dropdown_input(session, "ship_type", choices = ship_type_choices)
    
    # ----- Ship name
    observeEvent(input[["ship_type"]], {
      # Update ship_name choices, based on ship_type
      ship_name_choices <-
        data %>% filter(ship_type == input[["ship_type"]]) %>% .$SHIPNAME %>% factor %>% levels
      update_dropdown_input(session, "ship_name", choices = ship_name_choices)
    })
    
    return(list(ship_type = reactive( input[["ship_type"]] ),
                ship_name = reactive( input[["ship_name"]]) ))
  })
}
    
## To be copied in the UI
# mod_select_vessel_ui("select_vessel_ui_1")
    
## To be copied in the server
# mod_select_vessel_server("select_vessel_ui_1")
