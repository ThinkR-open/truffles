
#' check_param
#' @noRd
check_param <- function(param, type) {
  if (isFALSE(inherits(param, type))) {
    stop(paste(deparse(substitute(param)), "must be a", type))
  }

  return(invisible())
}

#' check_names_dataframe
#' @noRd
check_names_dataframe <- function(names, df) {
  check_ <- names %in% names(df)

  if (!all(check_)) {
    stop(paste("Missing Column(s) :", paste(names[!check_], collapse = ", ")))
  }

  return(invisible())
}

