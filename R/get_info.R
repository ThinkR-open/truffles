
#' Get information about oak and truffles
#'
#' This function retrieves information about oak trees and truffles based on the provided
#' databases and oak tree ID.
#'
#' @param dbchene Database containing information about oak trees.
#' @param dbtruffe Database containing information about truffles.
#' @param dbreensemence Database containing reseeding information.
#' @param theidchene ID of the oak tree for which information is to be retrieved.
#'
#' @return A list containing information about oak trees and truffles.
#'
#'
#' @export
#' @examples
#' conn <- DBI::dbConnect(RSQLite::SQLite(), system.file("chenes_truffe.sqlite", package = "truffles"))
#' chene <- DBI::dbReadTable(conn, name = "chenes_feularde")
#' truffe <- DBI::dbReadTable(conn, name = "truffe")
#' reensemence <- DBI::dbReadTable(conn, name = "reens")
#'
#' get_info(dbchene = chene, dbtruffe = truffe, dbreensemence = reensemence, theidchene = "162")
#' DBI::dbDisconnect(conn)
get_info <- function(dbchene, dbtruffe, dbreensemence, theidchene) {
  resultat <- list(
    chene = get_info_chene(dbchene = dbchene, theidchene = theidchene),
    truffes = get_info_chene_truffe(dbtruffe = dbtruffe, theidchene = theidchene),
    reensemence = get_info_reensemence(dbreensemence = dbreensemence, theidchene = theidchene)
  )

  return(resultat)
}
