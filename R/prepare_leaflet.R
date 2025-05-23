
#' Prepare Leaflet Data
#'
#' This function prepares data for Leaflet JavaScript visualization.
#'
#' @param dboak A data frame containing information about oak trees.
#' @param dbtruffle A data frame containing information about truffles.
#' @param dbreens A data frame containing information about reensemencement.
#' @importFrom dplyr filter mutate distinct full_join
#' @importFrom purrr set_names
#' @return A list suitable for passing to Leaflet JavaScript for visualization.
#'
#' @export
#' @examples
#' dboak <- data.frame(
#'   idoak = c(1, 2, 3),
#'   chene_nom = c("Chene 1", "Chene 2", "Chene 3")
#' )
#' 
#' dbreens <- data.frame(
#'   idreens = c(8),
#'   idoak = c(2),
#'   date_reens = c("2022-04-30")
#' )
#' 
#' dbtruffle <- data.frame(
#'   idoak = c(1, 1, 3),
#'   idtruffle = c(1, 2, 3),
#'   estimation = c(1, 0, 1),
#'   weight = c(10, 15, NA)
#' )
#' prepare_leaflet(dboak, dbtruffle, dbreens)
prepare_leaflet <- function(dboak, dbtruffle, dbreens) {
  t <- dbtruffle |>
    dplyr::filter(estimation == 1 | is.na(weight)) |>
    dplyr::mutate(info_missing = 1) |>
    dplyr::distinct(idoak, info_missing)

  r <- dbreens |>
        dplyr::mutate(info_reens = 1) |>
        dplyr::distinct(idoak, info_reens)
  c <- dboak |>
    dplyr::full_join(
      t,
      by = "idoak"
    ) |>
    dplyr::full_join(
      r,
      by = "idoak"
    )

  data_prep <- lapply(
    1:nrow(c),
    function(i) {
      unname(as.list(as.character(c[i, ]))) |> 
      set_names(names(c))
    }
  )

  return(list(
    data_prep = data_prep,
    names_element = names(c)
  ))
}
