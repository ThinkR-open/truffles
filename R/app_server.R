#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom DBI dbConnect dbReadTable
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
}
