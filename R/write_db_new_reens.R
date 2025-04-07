
#' Write new reensemencement data to the database
#'
#' This function writes new reensemencement data to the specified database table.
#'
#' @param conn A connection to the database.
#' @param theidoak The ID of the oak tree (oak) where the truffle was found.
#' @param date_reens The date of the reensemencement.
#' @param digest_ The digest of the reensemencement data.

#'
#' @importFrom digest digest
#' @importFrom DBI dbAppendTable
#' @return NULL
#'
#' @export
#' @examples
#' # write_db_new_reens(theidoak = "chene")
write_db_new_reens <-
  function(conn = connect_db(), theidoak, date_reens, digest_ = Sys.time()) {
    idreens <- digest(digest_)

    add_reens <- data.frame(
      idreens = idreens,
      idoak = theidoak,
      date_reens = as.character(date_reens)
    )

    dbAppendTable(conn, "reens", add_reens)
    message("WRITING in DB reensemencement")
  }
