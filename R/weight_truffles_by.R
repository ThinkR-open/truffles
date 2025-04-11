
#' Calculate total weight of truffles grouped by specified columns
#'
#' This function calculates the total weight of truffles grouped by specified columns
#' in a given data frame.
#'
#' @param dbtruffle A data frame containing information about truffles.
#' @param ... Columns to group by, passed as arguments.
#'
#' @return A summarized data frame containing the total weight of truffles
#' grouped by the specified columns.
#' @importFrom dplyr mutate group_by summarise
#' @importFrom lubridate year
#' @export
#' @examples
#'
#' library(dplyr)
#'
#' conn <- DBI::dbConnect(
#'    RSQLite::SQLite(),
#'    system.file(dbname = "chenes_truffe.sqlite", package = "truffles")
#'  )
#' truffes <- DBI::dbReadTable(conn, name = "truffe")
#'
#' weight_truffles_by(truffes, annee = lubridate::year(as.Date(date_found)))
#'
#' truffes_chene <- truffes |>
#'   inner_join(DBI::dbReadTable(conn, name = "chenes"), by = "idoak")
#' weight_truffles_by(truffes_chene, annee = lubridate::year(as.Date(date_found)), type)
weight_truffles_by <- function(dbtruffle, ...) {
  check_param(dbtruffle, "data.frame")
  check_names_dataframe(c("weight"), dbtruffle)

  dbtruffle |>
    group_by(...) |>
    summarise(weight = sum(weight, na.rm = TRUE), .groups = "drop")
}
