#' Check for duplicates
#' 
#' Checks for duplicated items in a vector or list and throw an error if found.
#' 
#' @param x A vector or list.
#' 
#' @returns Null
#' 
#' @keywords internal
check_duplicates <- function(x) {
    stp_msg <- paste("Duplicated items found in the label list. Please input",
                    "unique experiment and motif labels.")
    if (any(duplicated(x))) {
        stopper(stp_msg)
    }
}
