#' log_shiny
#'
#' @description A utils function
#' @param message character
#' @return a short message.
#' @importFrom cli cli_alert_info cli_alert_danger cli_rule
#'
#' @noRd
info <- function(message) {
  cli::cli_alert_info(
    paste0(
      "[INFO] : ",
      Sys.time(),
      " - ",
      message
    )
  )
}

danger <- function(message) {
  cli::cli_alert_danger(
    paste0(
      "[DANGER] : ",
      Sys.time(),
      " - ",
      message
    )
  )
}

rule <- function(message) {
  cli::cli_rule(
    paste0(
      Sys.time(),
      " - ",
      message
    )
  )
}

#' @noRd
log_dev <- function(f, ...) {
  if (golem::app_dev()) {
    f(...)
  }
}

#' @noRd
log_info_dev <- function(...) {
  log_dev(info, ...)
}

#' @noRd
log_danger_dev <- function(...) {
  log_dev(danger, ...)
}

#' @noRd
log_rule_dev <- function(...) {
  log_dev(rule, ...)
}

#' @noRd
log_where_r_u <- function() {
  log_info_dev(
    deparse(sys.calls()[grepl("observe|render:", sys.calls())][[1]])
  )
}
