#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom DBI dbConnect dbReadTable
#' @importFrom dplyr select filter
#' @importFrom gargoyle init trigger on watch
#' @noRd
app_server <- function(input, output, session) {
  global <- reactiveValues(
    conn = NULL,
    chenes_feularde = NULL,
    truffe = NULL
  )


  # Initiating the flags
  init("updatedb")

  observeEvent(TRUE, {
    log_info_dev("Connect db")
    global$conn <- dbConnect(SQLite(), system.file("chenes_truffe.sqlite", package = "truffles"))

    trigger("updatedb")
  })

  observe({
    watch("updatedb")
    log_info_dev("Read table db")
    global$chenes_feularde <- dbReadTable(global$conn, name = "chenes_feularde") |>
      filter(present == 1)
    global$truffe <- dbReadTable(global$conn, name = "truffe")
  })

  mod_carto_leaflet_server("carto_leaflet_1", global = global)

  observeEvent(input$chene_click, {
    req(input$chene_click)

    log_info_dev("observeEvent(input$chene_click, ...")
    info <- get_info(dbchene = global$chenes_feularde, dbtruffe = global$truffe, theidchene = input$chene_click)

    golem::invoke_js(
      "modal",
      list(
        id = input$chene_click,
        type = info$chene$type,
        date_p = as.Date(info$chene$date_plantation),
        der_truf = info$truffes$derniere_truffe,
        tot_poids = info$truffes$poids_tot,
        comments = info$truffes$comments
      )
    )
  })


  observeEvent(input$new_truffe, {
    req(input$new_truffe)

    log_info_dev("observeEvent(input$new_truffe, ...")
    write_db_new_truffe(global$conn, input$new_truffe[1], input$new_truffe[2], input$new_truffe[3], input$new_truffe[4])
    trigger("updatedb")
  })

  mod_dataviz_server("dataviz_1", global = global)
}
