
#' Get information about an oak tree
#'
#' This function retrieves information about a specific oak tree based on its ID
#' from the provided oak tree database.
#'
#' @param dbchene Database containing information about oak trees.
#' @param theidchene ID of the oak tree for which information is to be retrieved.
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
#' get_info_chene(dbchene = chene, theidchene = "162")
#'
get_info_chene <- function(dbchene, theidchene) {
  check_param(dbchene, "data.frame")
  check_param(theidchene, "character")
  check_names_dataframe(c("id", "type", "date_plantation"), dbchene)

  chene <- dbchene |>
    filter(id == theidchene)

  return(list(
    type = chene$type,
    date_plantation = as.Date(chene$date_plantation)
  ))
}
