
#' Get information about truffles associated with an oak tree
#'
#' This function retrieves information about truffles associated with a specific oak tree
#' based on the oak tree's ID from the provided truffle database.
#'
#' @param dbtruffle Database containing information about truffles.
#' @param theidoak ID of the oak tree for which information about associated truffles
#' is to be retrieved.
#'
#' @return A list containing information about truffles associated with the oak tree,
#' including the total weight, date of the last truffle found, and any comments.
#'
#' @importFrom dplyr filter summarise pull arrange desc
#' @export
#'
#' @examples
#' conn <- DBI::dbConnect(
#'    RSQLite::SQLite(),
#'    system.file(dbname = "chenes_truffe.sqlite", package = "truffles")
#'  )
#' truffe <- DBI::dbReadTable(conn, name = "truffe")
#'
#' get_info_oak_truffle(dbtruffle = truffe, theidoak = "119")
#' DBI::dbDisconnect(conn)
get_info_oak_truffle <- function(dbtruffle, theidoak) {
    check_param(dbtruffle, "data.frame")
    check_param(theidoak, "character")
    check_names_dataframe(c(
        "idoak", "weight", "date_found",
        "comment"
    ), dbtruffle)
    truffle_oak <- filter(dbtruffle, idoak == theidoak)
    if (nrow(truffle_oak) == 0) {
        return(list(weight_tot = 0, last_truffle = "-", last_comment = "-", other_comments = "-"))
    }


    weight_tot <- pull(summarise(truffle_oak, weight_tot = sum(weight,
        na.rm = TRUE
    )), weight_tot)
    last_truffle <- pull(summarise(truffle_oak, date_found = as.Date(max(date_found,
        na.rm = TRUE
    ))), date_found)

    sort_comment <- truffle_oak |>
        arrange(desc(date_found))

    last_comment <- paste(as.Date(sort_comment$date_found[1]),
        sort_comment$comment[1],
        sep = " : "
    )

    if (nrow(sort_comment) > 1) {
        other_comments <- paste(paste(as.Date(sort_comment$date_found[-1]),
            sort_comment$comment[-1],
            sep = " : "
        ), collapse = "<br>")
    } else {
        other_comments <- "-"
    }



    return(list(
        weight_tot = weight_tot, 
        last_truffle = last_truffle,
        last_comment = last_comment,
        other_comments = other_comments
    ))
}