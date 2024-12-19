#' Print denovo motif enrichment \code{\link[DT]{datatable}} and download
#' buttons for related files.
#' 
#' @param motif_list A list of motifs discovered by
#' \code{\link{find_motifs}}, for one comparison pair.
#' @param similar_motifs A list of similar motifs discovered using
#' \code{\link{motif_similarity}}, for one comparison pair.
#' @param segregated_peaks A list of peaks segregated by common and unique
#' groups, for one comparison pair.
#' @param indices A list of indices to print the \code{datatable} and download
#' buttons for.
#' @param jaspar_link A logical indicating whether to include a link to the
#' JASPAR database for the motifs. Only set to \code{TRUE} if the motifs are
#' in JASPAR format (example: "MA1930.1").
#' @param download_buttons Embed download buttons generated using
#' \code{\link{get_download_buttons}}. If set to \code{NULL}, no download
#' buttons will be added.
#' 
#' @import dplyr
#' @importFrom purrr map_df map_chr
#' @importFrom utils capture.output
#' 
#' @returns Null
#' 
#' @family datatable functions
#' 
#' @keywords internal
print_denovo_sections <- function(motif_list,
                                similar_motifs,
                                segregated_peaks,
                                indices,
                                jaspar_link = FALSE,
                                download_buttons = NULL) {
    headers <- list(
        paste0("  \n  **Reference Group - Common Peaks**  \nTotal peaks in ",
                "group: ", length(segregated_peaks$common_seqs1), "  \n"),
        paste0("  \n  **Comparison Group - Common Peaks**  \nTotal peaks in ",
                "group: ", length(segregated_peaks$common_seqs2), "  \n"),
        paste0("  \n  **Reference Group - Unique Peaks**  \nTotal peaks in ",
                "group: ", length(segregated_peaks$unique_seqs1), "  \n"),
        paste0("  \n  **Comparison Group - Unique Peaks**  \nTotal peaks in ",
                "group: ", length(segregated_peaks$unique_seqs2), "  \n")
    )
    out <- list()
    
    ### DT Func ###
    .print_dt <- function(i) {
        if (length(motif_list[[i]]) == 0 || length(similar_motifs[[i]]) == 0) {
            msg <- paste("*Either no motifs were discovered for this group, or",
                        "no similar motifs were found.*  \n")
            return(msg)
        }
        similar_motifs_i <- purrr::map_df(similar_motifs[[i]], as.data.frame)
        motif_DT <- motif_list[[i]] %>%
            left_join(similar_motifs_i, by = "name") %>%
            select("name", "consensus.x", "total_sites", "best_match_name",
                    "best_match_altname", "best_match_offset") %>%
            mutate("Motif Identifier" = substr(.data$name, 1, 3),
                    "Motif Width" = nchar(.data$consensus.x),
                    "% Peaks With Motif" = round(as.integer(.data$total_sites) /
                                    length(segregated_peaks[[i]]) * 100, 1)) %>%
            rename("Consensus Sequence" = "consensus.x",
                    "Peaks With Motif" = "total_sites",
                    "Best Match Name" = "best_match_name",
                    "Match Alt Name" = "best_match_altname",
                    "Match Offset" = "best_match_offset") %>%
            select("Motif Identifier", "Consensus Sequence", "Motif Width",
                    "Peaks With Motif", "% Peaks With Motif",
                    "Best Match Name", "Match Alt Name", "Match Offset") %>%
            arrange("Motif Identifier")
        
        rownames(motif_DT) <- motif_DT$`Motif Identifier`
        
        if (jaspar_link) {
            motif_DT <- motif_DT %>%
                mutate("Best Match Name" =
                        purrr::map_chr(.data$`Best Match Name`, link_JASPAR))
        }
        
        motif_DT <- motif_DT %>%
            select(!"Motif Identifier") %>%
            print_DT(escape = FALSE, html_tags = TRUE)
        return(motif_DT)
    }
    
    out_all <- list()
    for (i in indices) {
        out <- list()
        out$first <- paste(headers[[i]], "  \n  ")
        
        ### DT ###
        out$DT <- .print_dt(i)
        out$third <- "  \n  "
        
        ### Download Buttons ###
        if (!is.null(download_buttons)) {
            if (!is.null(download_buttons$peak_file[[i]]))
                out$fourth <- download_buttons$peak_file[[i]]
            if (!is.null(download_buttons$streme_output[[i]]))
                out$fifth <- download_buttons$streme_output[[i]]
            if (!is.null(download_buttons$tomtom_output[[i]]))
                out$sixth <- download_buttons$tomtom_output[[i]]
        }
        out_all[[which(indices == i)]] <- out
    }
    
    return(out_all)
}
