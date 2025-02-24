
#' Get the latest reseeding date for a given oak tree ID.
#'
#' This function retrieves the latest reseeding date for a specified oak tree ID
#' from a dataframe containing reseeding information.
#'
#' @param dbreensemence A data frame containing reseeding information with columns "idoak" and "date_reens".
#' @param theidoak The ID of the oak tree for which to retrieve the reseeding date.
#'
#' @return Returns the latest reseeding date for the specified oak tree ID. If no reseeding
#' information is available for the given ID, returns "-".
#'
#' @export
#' @examples
#' conn <- DBI::dbConnect(
#'    SQLite(),
#'    system.file(dbname, package = "truffles")
#'  )
#' reensemence <- DBI::dbReadTable(conn, name = "reens")
#'
#' get_info_reensemence(dbreensemence = reensemence, theidoak = "150")
#' DBI::dbDisconnect(conn)
get_info_reensemence <- function(dbreensemence, theidoak) {
  check_param(dbreensemence, "data.frame")
  check_param(theidoak, "character")
  check_names_dataframe(c("idoak", "date_reens"), dbreensemence)

  reensemence_chene <- dbreensemence |>
    filter(idoak == theidoak)

  if (nrow(reensemence_chene) == 0) {
    res <- "-"
  } else {
    res <- as.character(max(reensemence_chene$date_reens))
  }

  return(res)
}
