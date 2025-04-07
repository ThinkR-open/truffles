
#' Write new truffle data to the database
#'
#' This function writes new truffle data to the specified database table.
#'
#' @param conn A connection to the database.
#' @param theidoak The ID of the oak tree (oak) where the truffle was found.
#' @param date_found The date the truffle was found.
#' @param weight The weight of the truffle in grams.
#' @param estimation logical indicating whether the weight was estimated or not.
#' @param comment Any additional comments related to the truffle.
#' @param digest_ The digest of the truffle.
#'
#' @importFrom digest digest
#' @importFrom DBI dbAppendTable
#' @return NULL
#'
#' @export
#' @examples
#' # write_db_new_truffe(theidoak = "chene")
write_db_new_truffe <-
  function(conn = connect_db(), theidoak, date_found, weight, estimation, comment, digest_ = Sys.time()) {
    idtruffle <- digest(digest_)

    add_truffe <- data.frame(
      idtruffle = idtruffle,
      idoak = theidoak,
      date_found = as.character(date_found),
      weight = weight,
      estimation = estimation,
      comment = comment
    )

    dbAppendTable(conn, "truffe", add_truffe)
    message("WRITING in DB truffe")
  }
