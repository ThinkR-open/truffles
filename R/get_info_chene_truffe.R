
#' Get information about truffles associated with an oak tree
#'
#' This function retrieves information about truffles associated with a specific oak tree
#' based on the oak tree's ID from the provided truffle database.
#'
#' @param dbtruffe Database containing information about truffles.
#' @param theidoak ID of the oak tree for which information about associated truffles
#' is to be retrieved.
#'
#' @return A list containing information about truffles associated with the oak tree,
#' including the total weight, date of the last truffle found, and any comments.
#'
#' @importFrom dplyr filter summarise pull
#' @export
#'
#' @examples
#' conn <- DBI::dbConnect(
#'    RSQLite::SQLite(),
#'    system.file(dbname, package = "truffles")
#'  )
#' truffe <- DBI::dbReadTable(conn, name = "truffe")
#'
#' get_info_chene_truffe(dbtruffe = truffe, theidoak = "119")
#' DBI::dbDisconnect(conn)
get_info_chene_truffe <- function(dbtruffe, theidoak) {
  check_param(dbtruffe, "data.frame")
  check_param(theidoak, "character")
  check_names_dataframe(c("idoak", "weight", "date_found", "comment"), dbtruffe)

  truffe_chene <- dbtruffe |>
    filter(idoak == theidoak)

  if (nrow(truffe_chene) == 0) {
    return(list(
      weight_tot = 0,
      derniere_truffe = "-",
      comments = "-"
    ))
  }

  weight_tot <- truffe_chene |>
    summarise(weight_tot = sum(weight, na.rm = TRUE)) |>
    pull(weight_tot)

  derniere_truffe <- truffe_chene |>
    summarise(date_found = as.Date(max(date_found, na.rm = TRUE))) |>
    pull(date_found)

  comments <-
    paste(
      paste(
        as.Date(truffe_chene$date_found),
        truffe_chene$comment,
        sep = " : "
      ),
      collapse = "<br>"
    )

  return(list(
    weight_tot = weight_tot,
    derniere_truffe = derniere_truffe,
    comments = comments
  ))
}
