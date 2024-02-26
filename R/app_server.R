#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom DBI dbConnect dbReadTable
#' @importFrom dplyr select filter
#' @noRd
app_server <- function(input, output, session) {
  global <- reactiveValues(
    conn = NULL,
    chenes_feularde = NULL,
    truffe = NULL
  )
  observe({
    global$conn <- dbConnect(SQLite(), system.file("chenes_truffe.sqlite", package = "truffles"))
    global$chenes_feularde <- dbReadTable(global$conn, name = "chenes_feularde")
    global$truffe <- dbReadTable(global$conn, name = "truffe")
  })

  mod_carto_leaflet_server("carto_leaflet_1", global = global)

  observeEvent(input$chene_click, {
    req(input$chene_click)
    print(input$chene_click)

    info <- global$chenes_feularde |>
      filter(id == input$chene_click) |>
      select(type, date_plantation)


    info_truffes <- get_info_chene_truffe(dbtruffe = global$truffe, idchene = input$chene_click)

    golem::invoke_js(
      "modal",
      list(
        id = input$chene_click,
        type = info$type,
        date_p = as.Date(info$date_plantation),
        der_truf = info_truffes$derniere_truffe,
        tot_poids = info_truffes$poids_tot
      )
    )
  })
}
