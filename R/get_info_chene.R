
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
#' chene <- DBI::dbReadTable(connect_db(), name = "chenes_feularde")
#'
#' get_info_chene(dbchene = chene, theidoak = "162")
#'
get_info_chene <- function(dbchene, theidoak) {
  check_param(dbchene, "data.frame")
  check_param(theidoak, "character")
  check_names_dataframe(c("idoak", "type", "planting_date"), dbchene)

  oak <- dbchene |>
    filter(idoak == theidoak)

  return(list(
    type = oak$type,
    planting_date = as.Date(oak$planting_date)
  ))
}
