
#' Get information about an oak tree
#'
#' This function retrieves information about a specific oak tree based on its ID
#' from the provided oak tree database.
#'
#' @param dbchene Database containing information about oak trees.
#' @param theidoak ID of the oak tree for which information is to be retrieved.
#'
#' @return A list containing information about the oak tree, including its type and
#' date of plantation.
#'
#' @importFrom dplyr filter
#' @return a list
#'
#' @export
#' @examples
#' 
#' conn <- DBI::dbConnect(
#'    RSQLite::SQLite(),
#'    system.file(dbname = "chenes_truffe.sqlite", package = "truffles")
#'  )
#' chene <- DBI::dbReadTable(conn, name = "chenes")
#'
#' get_info_oak(dboak = chene, theidoak = "162")
#'
get_info_oak <- function(dboak, theidoak) {
  check_param(dboak, "data.frame")
  check_param(theidoak, "character")
  check_names_dataframe(c("idoak", "type", "planting_date"), dboak)

  oak <- dboak |>
    filter(idoak == theidoak)

  return(list(
    type = oak$type,
    planting_date = as.Date(oak$planting_date)
  ))
}
