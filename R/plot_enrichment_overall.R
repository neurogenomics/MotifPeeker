#' Plot motif-enrichment for all experiments
#' 
#' Visualises the result from \code{\link{get_df_enrichment}} for a single motif
#' by producing a \code{plotly} bar plot with the motif enrichment comparisons
#' for all the comparison dataset pair.
#' 
#' @param reference_label The label of the reference experiment.
#' @inheritParams plot_enrichment_individual
#' 
#' @import ggplot2
#' @import dplyr
#' @importFrom tidyr pivot_longer
#' @importFrom htmltools tagList
#'
#' @returns A list of \code{plotly} objects with the peak motif enrichment data.
#' If \code{html_tags} is \code{TRUE}, the function returns a list of
#' \code{tagList} objects instead. The two plots in the list are named as
#' follows:
#' \describe{
#'  \item{\code{$count_plt}}{y-axis represents the number of peaks.}
#'  \item{\code{$perc_plt}}{y-axis represents the percentage of peaks.}
#' }
#' 
#' @examples
#' data("CTCF_ChIP_peaks", package = "MotifPeeker")
#' data("CTCF_TIP_peaks", package = "MotifPeeker")
#' data("motif_MA1102.3", package = "MotifPeeker")
#' data("motif_MA1930.2", package = "MotifPeeker")
#' input <- list(
#'     peaks = list(CTCF_ChIP_peaks, CTCF_TIP_peaks),
#'     exp_type = c("ChIP", "TIP"),
#'     exp_labels = c("CTCF_ChIP", "CTCF_TIP"),
#'     read_count = c(150, 200),
#'     peak_count = c(100, 120)
#' )
#' segregated_input <- segregate_seqs(input$peaks[[1]], input$peaks[[2]])
#' motifs <- list(
#'     motifs = list(motif_MA1930.2, motif_MA1102.3),
#'     motif_labels = list("MA1930.2", "MA1102.3")
#' )
#'     
#' \donttest{
#'     if (requireNamespace("BSgenome.Hsapiens.UCSC.hg38")) {
#'         genome_build <-
#'             BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
#'         enrichment_df <- get_df_enrichment(
#'             input, segregated_input, motifs, genome_build,
#'             reference_index = 1, workers = 1
#'         )
#'         label_colours <- c("red", "cyan")
#'     
#'         plt <- plot_enrichment_overall(
#'         enrichment_df, motif_i = 1, label_colours = label_colours,
#'         reference_label = "CTCF_ChIP", html_tags = FALSE
#'         )
#'         print(plt$count_plot)
#'         print(plt$perc_plot)
#'     }
#' }
#' 
#' @family plot functions
#' 
#' @export
plot_enrichment_overall <- function(enrichment_df,
                                    motif_i,
                                    label_colours,
                                    reference_label,
                                    html_tags = TRUE) {
    enrichment_df_overall <- enrichment_df %>%
        filter(.data$motif_indice == motif_i, .data$group1 != "all") %>%
        group_by(.data$group1, .data$group2) %>%
        mutate(id = as.factor(row_number())) %>%
        tidyr::pivot_longer(cols = starts_with("count_") | starts_with("perc_"),
                    names_to = c(".value", "enriched"), names_sep = "_") %>%
        mutate(enriched = ifelse(.data$enriched == "enriched", "Yes", "No"))
    
    .plot_enrichment_overall <- function(y_val, y_title) {
        plt <- enrichment_df_overall %>%
            ggplot(aes(x = .data$id, y = y_val, fill = .data$enriched,
                        text = paste0(
                            "<b>Peak Group:</b> ", .data$group2, "<br>",
                            "<b>Reference Group:</b> ", reference_label, "<br>",
                            "<b>Comparison Group:</b> ", .data$exp_label,
                            "<br>",
                            "<b>Motif Present in Peak?:</b> ", .data$enriched,
                            "<br>",
                            "<b>Peak Count:</b> ", .data$count, " (",
                            .data$perc, "%)"))) +
            geom_bar(stat = "identity") +
            scale_fill_manual(name = "Motif Present", labels = c("No", "Yes"),
                                values = label_colours) +
            facet_grid(.data$group2 ~ .data$group1) +
            labs(x = "Comparison-Reference Pair", y = y_title,
                fill = "Motif Present")
        return(plt)
    }
    
    enrichment_overall_plt1 <- .plot_enrichment_overall(
        y_val = enrichment_df_overall$count, y_title = "Peak Count")
    enrichment_overall_plt2 <- .plot_enrichment_overall(
        y_val = enrichment_df_overall$perc, y_title = "Peak Percentage")
    
    pltly1 <- to_plotly(enrichment_overall_plt1, html_tags = FALSE) %>%
        layout(legend = list(traceorder = "reversed", x = 1.05))
    pltly2 <- to_plotly(enrichment_overall_plt2, html_tags = FALSE) %>%
        layout(legend = list(traceorder = "reversed", x = 1.05))
    
    if (html_tags) return(list(count_plt = htmltools::tagList(pltly1),
                                perc_plt = htmltools::tagList(pltly2)))
    return(list(count_plt = pltly1, perc_plt = pltly2))
}
