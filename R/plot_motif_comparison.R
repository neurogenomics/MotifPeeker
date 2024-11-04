#' Produce heat maps of motif similarity matrices
#'
#' @param comparison_matrices Output from \code{\link{compare_motifs}} for one
#' comparison pair (Four matrices).
#' @param exp_labels Labels for the reference and comparison experiments
#' respectively.
#' @inheritParams heatmaply::heatmaply
#' @inheritParams to_plotly
#' 
#' @importFrom plotly subplot layout
#' @importFrom heatmaply heatmaply
#' @importFrom viridis viridis
#' @importFrom utils capture.output
#' 
#' @returns A list of individual heat maps for the four matrices. If
#' \code{html_tags} is \code{TRUE}, the output will be wrapped in HTML tags.
#' 
#' @family plot functions
#' 
#' @keywords internal
plot_motif_comparison <- function(comparison_matrices,
                                exp_labels,
                                height = NULL,
                                width = NULL,
                                html_tags = TRUE) {
    lim <- c(min(unlist(comparison_matrices), na.rm = TRUE) - 0.1,
            max(unlist(comparison_matrices), na.rm = TRUE) + 0.1)
    
    axis_labels <- list(
        reference_common = paste(exp_labels[1], " Motifs \n(Common Peaks)"),
        comparison_common = paste(exp_labels[2], "Motifs \n(Common Peaks)"),
        reference_unique = paste(exp_labels[1], "Motifs \n(Unique Peaks)"),
        comparison_unique = paste(exp_labels[2], "Motifs \n(Unique Peak)")
    )
    
    .plot_all <- function(matrices, dendrogram = TRUE) {
        lapply(seq_len(4), function(x) {
            if (x == 1) {
                ylab <- axis_labels$reference_common
                xlab <- axis_labels$comparison_common
            } else if (x == 2) {
                ylab <- axis_labels$reference_unique
                xlab <- axis_labels$comparison_unique
            } else if (x == 3) {
                ylab <- axis_labels$reference_unique
                xlab <- axis_labels$comparison_common
            } else {
                ylab <- axis_labels$comparison_unique
                xlab <- axis_labels$reference_common
            }
            if (all(is.na(matrices[[x]]))) {
                msg <- paste("*No motifs were discovered",
                "in one or both the comparison groups. Skipping plot...*  \n")
                return(msg)
            }
            if (nrow(matrices[[x]]) < 2 || ncol(matrices[[x]]) < 2) {
                dendrogram <- "none"
            }
            heatmaply::heatmaply(matrices[[x]],
                colors = viridis::viridis(n = 256, option = "A"), limits = lim,
                xlab = xlab, ylab = ylab, dendrogram = dendrogram,
                key.title = "PCC", colorbar_len = 0.6, width = width,
                height = height)
        })
    }
    
    individual_plots <- .plot_all(comparison_matrices, TRUE)
    
    if (html_tags) {
        return(lapply(individual_plots, function(x) htmltools::tagList(x)))
    }
    return(individual_plots)
}
