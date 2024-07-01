#' Print the labels of the reference and comparison experiments
#'
#' @param exp_labels A character vector of experiment labels.
#' @param reference_index The index of the reference experiment.
#' @param comparison_index The index of the comparison experiment.
#' @param read_counts A numeric vector of read counts for each experiment.
#' (optional)
#' 
#' @returns None (invisible \code{NULL})
#' 
#' @keywords internal
print_labels <- function(exp_labels,
                        reference_index,
                        comparison_index,
                        read_counts = NULL) {
    cat("\n### ", exp_labels[comparison_index], " {- .unlisted}  \n")
    cat("**Reference Experiment Label**: ",
        exp_labels[reference_index])
    if (!is.null(read_counts)) {
        cat(" (Total Reads: ", paste0(
                pretty_number(read_counts[reference_index]), ")  \n"
            ))
    } else {
        cat("  \n")
    }
        
    cat("**Comparison Experiment Label**: ",
        exp_labels[comparison_index])
    if (!is.null(read_counts)) {
        cat(" (Total Reads: ", paste0(
                pretty_number(read_counts[comparison_index]), ")  \n"
            ))
    } else {
        cat("  \n")
    }
}
