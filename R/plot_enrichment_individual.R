#' Plot motif-enrichment for individual experiments
#' 
#' Visualises the result from \code{\link{get_df_enrichment}} for a single motif
#' by producing a \code{plotly} bar plot with the motif enrichment comparisons
#' for one comparison dataset pair.
#' 
#' @param enrichment_df A data frame containing the motif enrichment results,
#' produced using \code{\link{get_df_enrichment}}.
#' @param comparison_i The index of the comparison dataset to plot.
#' @param motif_i The index of the motif to plot.
#' @param label_colours A vector with colours (valid names or hex codes) to use
#' for "No" and "Yes" bar segments.
#' @inheritParams get_df_enrichment
#' @inheritParams to_plotly
#' 
#' @import ggplot2
#' @import dplyr
#' @importFrom tidyr pivot_longer
#' @importFrom htmltools tagList
#' @rawNamespace import(plotly, except = last_plot)
#'
#' @returns A \code{plotly} object with the peak motif enrichment data. If
#' \code{html_tags} is \code{TRUE}, the function returns a \code{tagList} object
#' instead.
#' 
#' @family plot functions
#' 
#' @keywords internal
plot_enrichment_individual <- function(result,
                                        enrichment_df,
                                        comparison_i,
                                        motif_i,
                                        label_colours,
                                        reference_index = 1,
                                        html_tags = TRUE) {
    stp_msg <- "reference_index cannot be the same as comparison_i."
    if (reference_index == comparison_i) stop(stp_msg)
    
    ref_label <- result$exp_labels[reference_index]
    comp_label <- result$exp_labels[comparison_i]
    df_filtered <- enrichment_df %>%
        filter(enrichment_df$motif_indice == motif_i,
                enrichment_df$exp_label %in% c(ref_label, comp_label)) %>%
        tidyr::pivot_longer(cols = starts_with("count_") | starts_with("perc_"),
                            names_to = c(".value", "enriched"), names_sep = "_")
    
    group_labels_breaks <- c(
        paste("All\n", ref_label, "\nPeaks"),
        paste("All\n", comp_label, "\nPeaks"),
        paste("Common\n", ref_label, "\nPeaks"),
        paste("Common\n", comp_label, "\nPeaks"),
        paste("Unique\n", ref_label, "\nPeaks"),
        paste("Unique\n", comp_label, "\nPeaks")
    )
    
    df_filtered <- df_filtered %>%
        mutate(enriched = if_else(df_filtered$enriched == "enriched",
                                    "Yes", "No")) %>%
        mutate(group = rep(group_labels_breaks, each = 2))
    
    enrichment_df_filtered_plt <- df_filtered %>%
        group_by(df_filtered$group) %>%
        ggplot(aes(x = df_filtered$group, y = df_filtered$count,
                    fill = df_filtered$enriched,
                    text = paste0("<b>Peak Count:</b> ", df_filtered$count,
                                    " (", df_filtered$perc, "%)"))) +
        geom_bar(stat = "identity", position = "stack") +
        theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
        labs(x = "Peak Groups", y = "Peak Count") +
        scale_fill_manual(name = "Motif Present", labels = c("No", "Yes"),
                            values = label_colours)
    
    enrichment_df_filtered_pltly <- to_plotly(enrichment_df_filtered_plt) %>%
                                layout(legend = list(traceorder = "reversed"))
    
    if (html_tags) return(htmltools::tagList(enrichment_df_filtered_pltly))
    return(enrichment_df_filtered_pltly)
}
