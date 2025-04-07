
#' Update a row in the "truffe" table of a database.
#'
#' This function updates a row in the "truffe" table of a database using an SQL UPDATE query.
#'
#' @param conn A connection to the database.
#' @param idtruffle The identifier of the truffle to update.
#' @param idoak The identifier of the oak tree associated with the truffle.
#' @param date_found The date when the truffle was found.
#' @param weight The weight of the truffle.
#' @param comment The comments associated with the truffle.
#' @param estimation The estimation of the truffle.
#'
#' @return The function does not return any value, but it updates the corresponding row in the "truffe" table of the database.
#' @importFrom DBI dbExecute sqlInterpolate ANSI
#'
#' @export
#' @examples
#'
#' conn <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")
#'
#' # Create a truffle table in the database
#' DBI::dbWriteTable(
#'   conn,
#'   "truffe",
#'   data.frame(
#'     idtruffle = "156",
#'     idoak = "15",
#'     date_found = as.numeric(as.Date("2020/02/02")),
#'     weight = 12,
#'     estimation = 1,
#'     comment = "Comment"
#'   )
#' )
#'
#' update_db_truffe(
#'   conn,
#'   idtruffle = "156",
#'   idoak = "15",
#'   date_found = as.numeric(as.Date("2020/02/02")),
#'   weight = 22,
#'   estimation = 0,
#'   comment = "It's good!"
#' )
update_db_truffe <- function(conn, idtruffle, idoak, date_found, weight, comment, estimation) {
  # Build and execute the SQL query to update the line

  update_query <- DBI::sqlInterpolate(
    DBI::ANSI(),
    "UPDATE truffe SET idtruffle = ?,
                                    idoak = ?,
                                    date_found = ?,
                                    weight = ?,
                                    estimation = ?,
                                    comment = ?
                                    WHERE idtruffle = ?",
    idtruffle,
    idoak,
    date_found,
    weight,
    estimation,
    comment,
    idtruffle
  )

  DBI::dbExecute(conn, update_query)
  message("UPDATE db truffe")
}
