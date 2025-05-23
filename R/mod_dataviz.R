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
    ),
    tags$canvas(
      id = ns("graph2"),
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

    observeEvent(
      c(
        global$truffe,
        global$chenes
      ),
      {
        req(global$truffe)
        log_info_dev("Dataviz")

        # By year
        truf <- weight_truffles_by(global$truffe, annee = lubridate::year(as.Date(date_found)))

        golem::invoke_js(
          "byyear",
          list(
            id = ns("graph1"),
            label = "Poids en grammes",
            labels = truf$annee,
            data = truf$weight,
            title = "R\u00e9colte annuelle de truffes"
          )
        )

        # By year and type

        truf_chene <- global$truffe |>
          dplyr::inner_join(
            global$chenes,
            by = "idoak"
          ) |>
          weight_truffles_by(annee = lubridate::year(as.Date(date_found)), type) |> 
          tidyr::complete(annee, type) |>
          tidyr::replace_na(list(weight = 0))

        golem::invoke_js(
          "byyeartype",
          list(
            id = ns("graph2"),
            label1 = "Normal",
            label2 = "Vert",
            labels = unique(truf_chene$annee),
            data1 = truf_chene |> filter(type == "Normal") |> pull(weight),
            data2 = truf_chene |> filter(type == "Green") |> pull(weight),
            title = "R\u00e9colte annuelle de truffes par Type"
          )
        )
      }
    )
  })
}

## To be copied in the UI
# mod_dataviz_ui("dataviz_1")

## To be copied in the server
# mod_dataviz_server("dataviz_1")
