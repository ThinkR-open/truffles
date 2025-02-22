
#' Get Information about the Last Truffle Found on a Specific Oak Tree
#'
#' This function retrieves information about the last truffle found on a specific oak tree.
#'
#' @param dbtruffe A data frame containing information about truffles.
#' @param theidoak The ID of the oak tree.
#' @param filter_missing_info logical to filter truffle with missing data
#' @importFrom dplyr filter mutate
#' @return A data frame containing information about the last truffle found on the specified oak tree.
#'
#' @export
#' @examples
#'
#' dbtruffe <- data.frame(
#'   idoak = c("123", "123", "456", "789"),
#'   estimation = c(1, 0, 1, 0),
#'   weight = c(NA, 5, 10, 100),
#'   date_found = as.Date(c("2023-01-01", "2023-03-15", "2023-02-01", "2022-12-01"))
#' )
#'
#' get_info_chene_last_truffe(dbtruffe = dbtruffe, theidoak = "123")
#' get_info_chene_last_truffe(dbtruffe = dbtruffe, theidoak = "123", filter_missing_info = TRUE)
get_info_chene_last_truffe <- function(dbtruffe, theidoak, filter_missing_info = FALSE) {
  check_param(dbtruffe, "data.frame")
  check_param(theidoak, "character")
  check_param(filter_missing_info, "logical")
  check_names_dataframe(c("weight", "estimation", "idoak"), dbtruffe)


  if (!any(theidoak %in% dbtruffe$idoak)) {
    return(data.frame())
  }

  if (isTRUE(filter_missing_info)) {
    dbtruffe <- dbtruffe |>
      dplyr::filter(estimation == 1 | is.na(weight))
  }

  truffe_chene <- dbtruffe |>
    filter(idoak == theidoak) |>
    filter(date_found == max(date_found)) |>
    dplyr::mutate(estim_js = dplyr::case_when(
      estimation == 1 ~ "checked = 'checked'", # TODO : deplace
      TRUE ~ ""
    ))

  return(truffe_chene)
}
