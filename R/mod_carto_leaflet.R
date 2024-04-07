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
      tags$input(type = "checkbox", id = ns("reens_id"), value = "1"),
      tags$label("Rensemenc\u00e9"),
      style = "display: inline-block; margin-right: 10px;"
    ),
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


    local <- reactiveValues(
      df_prep = NULL
    )

    observe({
      req(global$chenes_feularde)
      log_info_dev("prepa leaflet")
      # prepa data to js
      local$df_prep <-
        lapply(
          1:nrow(global$chenes_feularde),
          function(i) {
            unname(as.list(as.character(global$chenes_feularde[i, ])))
          }
        )
    })

    observeEvent(
      c(
        input$reens_id # ,input$done_id
      ),
      {
        req(local$df_prep)

        golem::invoke_js(
          "map",
          list(
            id = ns("mymap"),
            data = local$df_prep,
            reens = as.numeric(input$reens_id) # ,
            # done = as.numeric(input$done_id)
          )
        )
      }
    )
  })
}

## To be copied in the UI
# mod_carto_leaflet_ui("carto_leaflet_1")

## To be copied in the server
# mod_carto_leaflet_server("carto_leaflet_1")
