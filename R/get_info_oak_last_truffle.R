
#' Get Information about the Last Truffle Found on a Specific Oak Tree
#'
#' This function retrieves information about the last truffle found on a specific oak tree.
#'
#' @param dbtruffle A data frame containing information about truffles.
#' @param theidoak The ID of the oak tree.
#' @param filter_missing_info logical to filter truffle with missing data
#' @importFrom dplyr filter mutate
#' @return A data frame containing information about the last truffle found on the specified oak tree.
#'
#' @export
#' @examples
#'
#' dbtruffle <- data.frame(
#'   idoak = c("123", "123", "456", "789"),
#'   estimation = c(1, 0, 1, 0),
#'   weight = c(NA, 5, 10, 100),
#'   date_found = as.Date(c("2023-01-01", "2023-03-15", "2023-02-01", "2022-12-01"))
#' )
#'
#' get_info_oak_last_truffle(dbtruffle = dbtruffle, theidoak = "123")
#' get_info_oak_last_truffle(dbtruffle = dbtruffle, theidoak = "123", filter_missing_info = TRUE)
get_info_oak_last_truffle <- function(dbtruffle, theidoak, filter_missing_info = FALSE) {
  check_param(dbtruffle, "data.frame")
  check_param(theidoak, "character")
  check_param(filter_missing_info, "logical")
  check_names_dataframe(c("weight", "estimation", "idoak"), dbtruffle)


  if (!any(theidoak %in% dbtruffle$idoak)) {
    return(data.frame())
  }

  if (isTRUE(filter_missing_info)) {
    dbtruffle <- dbtruffle |>
      dplyr::filter(estimation == 1 | is.na(weight))
  }

  truffle_oak <- dbtruffle |>
    filter(idoak == theidoak) |>
    filter(date_found == max(date_found)) |>
    dplyr::mutate(estim_js = dplyr::case_when(
      estimation == 1 ~ "checked = 'checked'", 
      TRUE ~ ""
    ))

  return(truffle_oak)
}
