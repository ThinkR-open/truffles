
#' Get information about oak and truffles
#'
#' This function retrieves information about oak trees and truffles based on the provided
#' databases and oak tree ID.
#'
#' @param dboak Database containing information about oak trees.
#' @param dbtruffle Database containing information about truffles.
#' @param dbreensemence Database containing reseeding information.
#' @param theidoak ID of the oak tree for which information is to be retrieved.
#'
#' @return A list containing information about oak trees and truffles.
#'
#'
#' @export
#' @examples
#' conn <- DBI::dbConnect(RSQLite::SQLite(), system.file("chenes_truffe.sqlite", package = "truffles"))
#' chene <- DBI::dbReadTable(conn, name = "chenes")
#' truffe <- DBI::dbReadTable(conn, name = "truffe")
#' reensemence <- DBI::dbReadTable(conn, name = "reens")
#'
#' get_info(dboak = chene, dbtruffle = truffe, dbreensemence = reensemence, theidoak = "162")
#' DBI::dbDisconnect(conn)
get_info <- function(dboak, dbtruffle, dbreensemence, theidoak) {
  resultat <- list(
    chene = get_info_oak(dboak = dboak, theidoak = theidoak),
    truffes = get_info_oak_truffle(dbtruffle = dbtruffle, theidoak = theidoak),
    reensemence = get_info_reensemence(dbreensemence = dbreensemence, theidoak = theidoak)
  )

  return(resultat)
}
