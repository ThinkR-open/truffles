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
    chenes = NULL,
    truffe = NULL
  )


  # Initiating the flags
  init("updatedb")

  observeEvent(TRUE, {
    tryCatch(
      { 
        if (isTRUE(getOption("golem.app.prod"))) {
          global$conn <- connect_db(
            port = Sys.getenv("DB_PORT_PROD"),
            user = Sys.getenv("DB_USER_PROD"),
            password = Sys.getenv("DB_PWD_PROD")
          )
        } else {
        global$conn <- connect_db()
        }
      },
      error = function(e) {
        log_info_dev("Database connection failed")
        f7Dialog(
          title = "Erreur de connexion",
          text = "Base de donn\u00e9es indisponible",
          type = "alert"
        )
      }
    )
    trigger("updatedb")
  })


  observe({
    watch("updatedb")
    req(global$conn)
    log_info_dev("Read table db")
    global$chenes <- dbReadTable(global$conn, name = "chenes") |>
      filter(present == 1)
    global$truffe <- dbReadTable(global$conn, name = "truffe")
    global$reensemence <- dbReadTable(global$conn, name = "reens")
  })

  mod_carto_leaflet_server("carto_leaflet_1", global = global)

  observeEvent(input$chene_click, ignoreNULL = FALSE, {
    req(input$chene_click)

    log_info_dev("observeEvent(input$chene_click, ...")


    if (isTRUE(global$missingdata)) {
      info <- get_info_chene_last_truffe(dbtruffe = global$truffe, theidoak = input$chene_click, filter_missing_info = TRUE)

      golem::invoke_js(
        "modal_info_missing",
        list(
          id = input$chene_click,
          idtruffle = info$idtruffle,
          date_t = as.Date(info$date_found),
          weight = info$weight,
          estim = info$estim_js,
          comments = info$comment
        )
      )
    } else {
      info <- get_info(
        dbchene = global$chenes,
        dbtruffe = global$truffe,
        dbreensemence = global$reensemence,
        theidoak = input$chene_click
      )

      golem::invoke_js(
        "modal",
        list(
          id = input$chene_click,
          type = info$chene$type,
          date_reens = info$reensemence,
          date_p = as.Date(info$chene$planting_date),
          der_truf = info$truffes$derniere_truffe,
          tot_weight = info$truffes$weight_tot,
          last_comment = info$truffes$last_comment,
          other_comments = info$truffes$other_comments
        )
      )
    }
  })


  observeEvent(input$new_truffe, {
    req(input$new_truffe)
    log_info_dev("observeEvent(input$new_truffe, ...")

    write_db_new_truffe(
      conn = global$conn,
      theidoak = input$new_truffe[1],
      date_found = input$new_truffe[2],
      weight = as.numeric(input$new_truffe[3]),
      estimation = as.numeric(as.logical(input$new_truffe[4])),
      comment = input$new_truffe[5]
    )

    trigger("updatedb")
  })

  observeEvent(input$new_reens, {
    req(input$new_reens)
    log_info_dev("observeEvent(input$new_reens, ...")

    write_db_new_reens(
      conn = global$conn,
      theidoak = input$new_reens[1],
      date_reens = input$new_reens[2]
    )

    trigger("updatedb")
  })

  observeEvent(input$complete_truffe, {
    req(input$complete_truffe)
    log_info_dev("observeEvent(input$complete_truffe, ...")

    update_db_truffe(
      conn = global$conn,
      idtruffle = input$complete_truffe[2],
      idoak = input$complete_truffe[1],
      date_found = as.character(input$complete_truffe[3]),
      weight = as.numeric(input$complete_truffe[4]),
      estimation = as.numeric(as.logical(input$complete_truffe[5])),
      comment = input$complete_truffe[6]
    )

    trigger("updatedb")
  })

  mod_dataviz_server("dataviz_1", global = global)
}
