#' Print the labels of the reference and comparison experiments
#'
#' @param exp_labels A character vector of experiment labels.
#' @param reference_index The index of the reference experiment.
#' @param comparison_index The index of the comparison experiment.
#' @param header_type Label for the section to print the header for. Options
#' are: "known_motif" and "denovo_motif".
#' @param read_counts A numeric vector of read counts for each experiment.
#' (optional)
#' 
#' @returns None (invisible \code{NULL})
#' 
#' @keywords internal
print_labels <- function(exp_labels,
                        reference_index,
                        comparison_index,
                        header_type,
                        read_counts = NULL) {
    if (header_type == "known_motif") {
        cat("\n### ", exp_labels[comparison_index], " {- .unlisted}  \n")
    } else if (header_type == "denovo_motif") {
        cat("\n## ", exp_labels[comparison_index], " {- .unlisted .tabset ",
        ".tabset-fade .tabset-pills}  \n")
    }
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
