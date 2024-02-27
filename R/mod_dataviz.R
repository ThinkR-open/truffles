#' dataviz UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_dataviz_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$canvas(
      id = ns("graph1"),
      style = "height: 800px;"
    )
  )
}

#' dataviz Server Functions
#'
#' @noRd
mod_dataviz_server <- function(id, global) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    observe({
      truf <- truffles_by_year(global$truffe)
      golem::invoke_js(
        "byyear",
        list(
          id = ns("graph1"),
          label = "Poids en grammes",
          labels = truf$annee,
          data = truf$poids,
          title = "R\u00e9colte annuelle de truffes"
        )
      )
    })
  })
}

## To be copied in the UI
# mod_dataviz_ui("dataviz_1")

## To be copied in the server
# mod_dataviz_server("dataviz_1")
