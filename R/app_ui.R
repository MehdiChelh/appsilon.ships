#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shiny.semantic
#' @importFrom leaflet leafletOutput
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    semanticPage(
      tags$div(
        class="ui container",
        tags$div(
          class="ui grid row",
          # --- Header
          h1(class = "ui header row", icon("ship"),
             div(class = "content", "Ships dataset (AIS data)",
                 div(class = "sub header", "Appsilon Homework Assignement"))),
          
          # --- Menu
          horizontal_menu(list(
            list(name = "Home", link = "#", icon = "home"),
            list(name = "Ships statistics", icon = "ship", class = "disabled")
          )),
          
          tags$div(
            class="ui stackable column row card",
            # --- Plot
            tags$div(
              class="ten wide column",
              leafletOutput("ship-map")
            ),
            tags$div(
              class="six wide column",
              # --- Vessel selection (dropdown_input)
              mod_select_vessel_ui("vessel_selection"),
              # --- Message
              div(
                class = "ui raised segment",
                div(
                  tags$span(class="ui blue ribbon label", "Vessel longest distance:"),
                  textOutput("vessel_distance")
                )
              )
            )
          )
        )
      )
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'appsilon.ships'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

