#' connect_db
#'
#' To connect to the database
#'
#' @param dbname name of db
#' @param host host of db
#' @param port port of db
#' @param user user of db
#' @param password password of db
#' 
#' @importFrom RPostgres Postgres
#' @importFrom DBI dbConnect
#' @return NULL
#'
#' @export
#' @examples
#' if (interactive()) {
#'   connect_db()
#' }
connect_db <- function(
    dbname = "postgres",
    host = Sys.getenv("DB_HOST", unset = ""),
    port = 6543, 
    user = Sys.getenv("DB_USER", unset = ""), 
    password = Sys.getenv("DB_PWD", unset = "")) {

  conn <- dbConnect(Postgres(),
    dbname = "postgres",
    host = host,
    port = port,
    user = user,
    password =password
  )
  return(conn)
}
