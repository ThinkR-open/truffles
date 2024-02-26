#' carto_leaflet UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_carto_leaflet_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$div(
      id = ns("mymap"),
      style = "height: 800px;"
    )
  )
}

#' carto_leaflet Server Functions
#'
#' @noRd
mod_carto_leaflet_server <- function(id, global) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns


    observe({
      # prepa data to js
      df_prep <-
        lapply(
          1:nrow(global$chenes_feularde),
          function(i) {
            unname(as.list(as.character(global$chenes_feularde[i, ])))
          }
        )


      golem::invoke_js(
        "map",
        list(
          id = ns("mymap"),
          data = df_prep
        )
      )
    })
  })
}

## To be copied in the UI
# mod_carto_leaflet_ui("carto_leaflet_1")

## To be copied in the server
# mod_carto_leaflet_server("carto_leaflet_1")
