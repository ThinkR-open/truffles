
#' Update a row in the "truffe" table of a database.
#'
#' This function updates a row in the "truffe" table of a database using an SQL UPDATE query.
#'
#' @param conn A connection to the database.
#' @param idtruffe The identifier of the truffle to update.
#' @param idchene The identifier of the oak tree associated with the truffle.
#' @param date_trouve The date when the truffle was found.
#' @param poids The weight of the truffle.
#' @param commentaires The comments associated with the truffle.
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
#'     idtruffe = "156",
#'     idchene = "15",
#'     date_trouve = as.numeric(as.Date("2020/02/02")),
#'     poids = 12,
#'     estimation = 1,
#'     commentaires = "Comment"
#'   )
#' )
#'
#' update_db_truffe(
#'   conn,
#'   idtruffe = "156",
#'   idchene = "15",
#'   date_trouve = as.numeric(as.Date("2020/02/02")),
#'   poids = 22,
#'   estimation = 0,
#'   commentaires = "It's good!"
#' )
update_db_truffe <- function(conn = connect_db(), idtruffe, idchene, date_trouve, poids, commentaires, estimation) {
  commentaires <- formater_comment(commentaires)

  # Build and execute the SQL query to update the line

  update_query <- DBI::sqlInterpolate(
    DBI::ANSI(),
    "UPDATE truffe SET idtruffe = ?,
                                    idchene = ?,
                                    date_trouve = ?,
                                    poids = ?,
                                    estimation = ?,
                                    commentaires = ?
                                    WHERE idtruffe = ?",
    idtruffe,
    idchene,
    date_trouve,
    poids,
    estimation,
    commentaires,
    idtruffe
  )

  DBI::dbExecute(conn, update_query)
  message("UPDATE db truffe")
}
