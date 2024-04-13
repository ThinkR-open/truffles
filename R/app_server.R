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
    global$conn <- connect_db()
    trigger("updatedb")
  })

  observe({
    watch("updatedb")
    req(global$conn)
    log_info_dev("Read table db")
    global$chenes_feularde <- dbReadTable(global$conn, name = "chenes_feularde") |>
      filter(present == 1)
    global$truffe <- dbReadTable(global$conn, name = "truffe")
    global$reensemence <- dbReadTable(global$conn, name = "reens")
  })

  mod_carto_leaflet_server("carto_leaflet_1", global = global)

  observeEvent(input$chene_click, ignoreNULL = FALSE, {
    req(input$chene_click)

    log_info_dev("observeEvent(input$chene_click, ...")


    if (isTRUE(global$missingdata)) {
      info <- get_info_chene_last_truffe(dbtruffe = global$truffe, theidchene = input$chene_click, filter_missing_info = TRUE)

      golem::invoke_js(
        "modal_info_missing",
        list(
          id = input$chene_click,
          idtruffe = info$idtruffe,
          date_t = as.Date(info$date_trouve),
          poids = info$poids,
          estim = info$estim_js,
          comments = info$commentaires
        )
      )
    } else {
      info <- get_info(
        dbchene = global$chenes_feularde,
        dbtruffe = global$truffe,
        dbreensemence = global$reensemence,
        theidchene = input$chene_click
      )

      golem::invoke_js(
        "modal",
        list(
          id = input$chene_click,
          type = info$chene$type,
          date_reens = info$reensemence,
          date_p = as.Date(info$chene$date_plantation),
          der_truf = info$truffes$derniere_truffe,
          tot_poids = info$truffes$poids_tot,
          comments = info$truffes$comments
        )
      )
    }
  })


  observeEvent(input$new_truffe, {
    req(input$new_truffe)
    log_info_dev("observeEvent(input$new_truffe, ...")

    write_db_new_truffe(
      conn = global$conn,
      theidchene = input$new_truffe[1],
      date_trouvee = input$new_truffe[2],
      poids = as.numeric(input$new_truffe[3]),
      estimation = as.logical(input$new_truffe[4]),
      comment = input$new_truffe[5]
    )

    trigger("updatedb")
  })


  observeEvent(input$complete_truffe, {
    req(input$complete_truffe)
    log_info_dev("observeEvent(input$complete_truffe, ...")

    update_db_truffe(
      conn = global$conn,
      idtruffe = input$complete_truffe[2],
      idchene = input$complete_truffe[1],
      date_trouve = as.numeric(as.Date(input$complete_truffe[3])),
      poids = as.numeric(input$complete_truffe[4]),
      estimation = as.numeric(as.logical(input$complete_truffe[5])),
      commentaires = input$complete_truffe[6]
    )

    trigger("updatedb")
  })

  mod_dataviz_server("dataviz_1", global = global)
}
