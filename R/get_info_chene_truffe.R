
#' Get information about truffles associated with an oak tree
#'
#' This function retrieves information about truffles associated with a specific oak tree
#' based on the oak tree's ID from the provided truffle database.
#'
#' @param dbtruffe Database containing information about truffles.
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
#' get_info_chene_truffe(dbtruffe = truffe, theidoak = "119")
#' DBI::dbDisconnect(conn)
get_info_chene_truffe <- function(dbtruffe, theidoak) {
    check_param(dbtruffe, "data.frame")
    check_param(theidoak, "character")
    check_names_dataframe(c(
        "idoak", "weight", "date_found",
        "comment"
    ), dbtruffe)
    truffe_chene <- filter(dbtruffe, idoak == theidoak)
    if (nrow(truffe_chene) == 0) {
        return(list(weight_tot = 0, derniere_truffe = "-", last_comment = "-", other_comments = "-"))
    }


    weight_tot <- pull(summarise(truffe_chene, weight_tot = sum(weight,
        na.rm = TRUE
    )), weight_tot)
    derniere_truffe <- pull(summarise(truffe_chene, date_found = as.Date(max(date_found,
        na.rm = TRUE
    ))), date_found)

    sort_comment <- truffe_chene |>
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
        derniere_truffe = derniere_truffe,
        last_comment = last_comment,
        other_comments = other_comments
    ))
}