#' carto_leaflet UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#' @importFrom shinyWidgets prettySwitch
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_carto_leaflet_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$div(
      prettySwitch(
        inputId = ns("missingdata"),
        label = "Info \u00e0 compl\u00e9ter",
        fill = TRUE,
        status = "primary"
      ),
      prettySwitch(
        inputId = ns("reens_id"),
        value = FALSE,
        label = "Rensemenc\u00e9",
        fill = TRUE,
        status = "primary"
      )
      # tags$input(type = "checkbox", id = ns("reens_id"), value = "1"),
      # tags$label("Rensemenc\u00e9"),
      # style = "display: inline-block; margin-right: 10px;"
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
      req(global$truffe)
      log_info_dev("prepa leaflet")
      # prepa data to js
      local$df_prep <- prepare_leaflet(
        dbchene = global$chenes_feularde,
        dbtruffe = global$truffe
      )
    })

    observeEvent(
      c(
        input$reens_id,
        input$missingdata,
        global$truffe,
        global$chenes_feularde
      ),
      ignoreNULL = FALSE,
      {
        req(local$df_prep)

        global$missingdata <- input$missingdata

        if (isTRUE(input$missingdata)) {
          thedata <- local$df_prep$data_prep |>
            purrr::keep(\(x) (x[8] == "1"))
          thereens <- 0
        } else {
          thedata <- local$df_prep$data_prep
          thereens <- as.numeric(input$reens_id)
        }

        golem::invoke_js(
          "map",
          list(
            id = ns("mymap"),
            data = thedata,
            reens = thereens
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
