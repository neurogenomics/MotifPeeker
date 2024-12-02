#' Get dataframe with motif enrichment values
#'
#' Wrapper for `MotifPeeker::motif_enrichment` to get motif enrichment counts
#' and percentages for all peaks and motifs, generating a \code{data.frame}
#' suitable for plots. The \code{data.frame} contains values for all and
#' segregated peaks.
#'
#' @param segregated_peaks A \code{list} object generated using
#' \code{\link{segregate_seqs}}.
#' @inheritParams get_df_distances
#' @inheritParams MotifPeeker
#' 
#' @importFrom purrr map_df
#' 
#' @return A \code{data.frame} with the following columns:
#' \describe{
#'  \item{exp_label}{Experiment labels.}
#'  \item{exp_type}{Experiment types.}
#'  \item{motif_indice}{Motif indices.}
#'  \item{group1}{Segregated group- "all", "Common" or "Unique".}
#'  \item{group2}{"reference" or "comparison" group.}
#'  \item{count_enriched}{Number of peaks with motif.}
#'  \item{count_nonenriched}{Number of peaks without motif.}
#'  \item{perc_enriched}{Percentage of peaks with motif.}
#'  \item{perc_nonenriched}{Percentage of peaks without motif.}
#' }
#' 
#' @examples
#' if (memes::meme_is_installed()) {
#'     data("CTCF_ChIP_peaks", package = "MotifPeeker")
#'     data("CTCF_TIP_peaks", package = "MotifPeeker")
#'     data("motif_MA1102.3", package = "MotifPeeker")
#'     data("motif_MA1930.2", package = "MotifPeeker")
#'     input <- list(
#'         peaks = list(CTCF_ChIP_peaks, CTCF_TIP_peaks),
#'         exp_type = c("ChIP", "TIP"),
#'         exp_labels = c("CTCF_ChIP", "CTCF_TIP"),
#'         read_count = c(150, 200),
#'         peak_count = c(100, 120)
#'     )
#'     segregated_input <- segregate_seqs(input$peaks[[1]], input$peaks[[2]])
#'     motifs <- list(
#'         motifs = list(motif_MA1930.2, motif_MA1102.3),
#'         motif_labels = list("MA1930.2", "MA1102.3")
#'     )
#'     reference_index <- 1
#' 
#'     if (requireNamespace("BSgenome.Hsapiens.UCSC.hg38")) {
#'         genome_build <-
#'             BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
#'     
#'         enrichment_df <- get_df_enrichment(
#'             input, segregated_input, motifs, genome_build,
#'             reference_index = 1
#'         )
#'     }
#' }
#' 
#' @family generate data.frames
#' 
#' @export
get_df_enrichment <- function(result,
                            segregated_peaks,
                            user_motifs,
                            genome_build,
                            reference_index = 1,
                            out_dir = tempdir(),
                            BPPARAM = BiocParallel::bpparam(),
                            meme_path = NULL,
                            verbose = FALSE) {
    if (!is.list(result$peaks)) result$peaks <- list(result$peaks)
    result_len <- length(result$peaks)
    motif_len <- length(user_motifs$motifs)
    comparison_indices <- setdiff(seq_len(result_len), reference_index)
    
    ## Skip if only one set of dataset is provided
    if (result_len == 1) return(NA)
    
    ## 1. All peaks
    peak_combinations <- rep(result$peaks, each = motif_len)
    exp_label_combinations <- rep(result$exp_labels, each = motif_len)
    exp_type_combinations <- rep(result$exp_type, each = motif_len)
    motif_combinations <- rep(user_motifs$motifs, result_len)
    
    enrichment_df_all <- bpapply(
        seq_len(result_len * motif_len),
        function(i) {
            peak <- peak_combinations[[i]]
            motif <- motif_combinations[[i]]
            res <- motif_enrichment(
                peak, motif,
                genome_build = genome_build,
                out_dir = file.path(out_dir, "ame_all", i),
                meme_path = meme_path,
                verbose = verbose
            )
            list(
                exp_label = exp_label_combinations[i],
                exp_type = exp_type_combinations[i],
                group1 = "all",
                group2 = ifelse(exp_label_combinations[i] ==
                                    result$exp_labels[reference_index],
                                "reference", "comparison"),
                motif_indice = rep(seq_len(motif_len), result_len)[i],
                count_enriched = res$tp[1],
                count_nonenriched =
                    rep(result$peak_count, each = motif_len)[i] - res$tp[1],
                perc_enriched = res$tp[2],
                perc_nonenriched = 
                    ifelse(res$tp[1] != 0, 100 - res$tp[2], 0),
                run_index = i
            )
        },
        BPPARAM = BPPARAM, verbose = verbose) %>%
        purrr::map_df(as.data.frame)
    
    ## 2. Segregated peaks
    ## Output: Peak1 common_seq1 - Motif 1
    ##         Peak1 common_seq1 - Motif 2
    ##         ...
    ##         Peak1 common_seq2 - Motif 1
    ##         ...
    ##         Peak2 common_seq1 - Motif 1
    ##         ...
    if (result_len == 2) segregated_peaks <- list(segregated_peaks)
    peak_combinations2 <- lapply(seq_along(comparison_indices), function(i) {
        rep(segregated_peaks[[i]], each = motif_len)
    }) %>% unlist
    exp_label_combinations2 <- lapply(comparison_indices, function(i) {
        rep(rep(result$exp_labels[i], 4), each = motif_len)
    }) %>% unlist
    exp_type_combinations2 <- lapply(comparison_indices, function(i) {
        rep(rep(result$exp_type[i], 4), each = motif_len)
    }) %>% unlist
    motif_combinations2 <- lapply(comparison_indices, function(i) {
        rep(seq_along(user_motifs$motifs), 4) # Indices
    }) %>% unlist %>% unname
    group1_labels <- rep(c("Common", "Unique"), each = 2 * motif_len,
                        length(comparison_indices))
    group2_labels <- rep(c("Reference", "Comparison"), each = motif_len,
                        length(comparison_indices) * 2)
    enrichment_df_seg <- bpapply(
        seq_len((result_len - 1) * 4 * motif_len),
        function(i) {
            peak <- peak_combinations2[[i]]
            motif <- user_motifs$motifs[motif_combinations2[[i]]]
            res <- MotifPeeker::motif_enrichment(
                peak, motif,
                genome_build = genome_build,
                out_dir = file.path(out_dir, "ame_segregated", i),
                meme_path = meme_path,
                verbose = verbose
            )
            list(
                exp_label = exp_label_combinations2[i],
                exp_type = exp_type_combinations2[i],
                group1 = group1_labels[i],
                group2 = group2_labels[i],
                motif_indice = motif_combinations2[i],
                count_enriched = res$tp[1],
                count_nonenriched = length(peak) - res$tp[1],
                perc_enriched = res$tp[2],
                perc_nonenriched =
                    ifelse(res$tp[1] != 0, 100 - res$tp[2], 0),
                run_index = i
            )
        },
        BPPARAM = BPPARAM, verbose = verbose) %>%
        purrr::map_df(as.data.frame)

    enrichment_df <- rbind(enrichment_df_all, enrichment_df_seg)
    return(enrichment_df)
}
