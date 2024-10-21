#' Get \code{\link[DT]{datatable}} for motif-enrichment of individual
#' experiments.
#' 
#' @inheritParams plot_enrichment_individual
#' 
#' @returns A \code{DT::datatable} object with the peak motif enrichment data
#' for the specified \code{comparison_i} and \code{motif_i}.
#' 
#' @family datatable functions
#' 
#' @keywords internal
dt_enrichment_individual <- function(result,
                                    enrichment_df,
                                    comparison_i,
                                    motif_i,
                                    reference_index = 1) {
    stp_msg <- "reference_index cannot be the same as comparison_i."
    if (reference_index == comparison_i) stop(stp_msg)
    
    ref_label <- result$exp_labels[reference_index]
    comp_label <- result$exp_labels[comparison_i]
    enrichment_group_labels <- c(
        paste("All", ref_label, "Peaks"),
        paste("All", comp_label, "Peaks"),
        paste("Common", ref_label, "Peaks"),
        paste("Common", comp_label, "Peaks"),
        paste("Unique", ref_label, "Peaks"),
        paste("Unique", comp_label, "Peaks")
    )
    
    df_filtered <- enrichment_df %>%
        filter(enrichment_df$motif_indice == motif_i,
                enrichment_df$exp_label %in% c(ref_label, comp_label)) %>%
        mutate(Group = enrichment_group_labels) %>%
        mutate(count_all = .data$count_enriched +
                    .data$count_nonenriched,
                .before = "count_enriched")
    
    enrichment_DT <- df_filtered %>%
        select("Group", starts_with("count_"), contains("perc_enriched")) %>%
        rename(
            "Total Peaks" = "count_all",
            "Peaks With Motif" = "count_enriched",
            "Peaks Without Motif" = "count_nonenriched",
            "Peaks With Motif (%)" = "perc_enriched"
        )
    return(print_DT(enrichment_DT, html_tags = TRUE))
}
