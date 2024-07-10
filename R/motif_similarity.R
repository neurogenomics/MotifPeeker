#' Compare motifs from segregated sequences
#' 
#' Compute motif similarity scores between motifs discovered from segregated
#' sequences. Wrapper around \code{\link[universalmotif]{compare_motifs}} to
#' compare motifs from different groups of sequences. To see the possible
#' similarity measures available, refer to details.
#' 
#' @inheritParams universalmotif::compare_motifs
#' @inheritParams find_motifs
#' @inheritDotParams universalmotif::compare_motifs
#' 
#' @importFrom universalmotif compare_motifs
#' 
#' @inherit universalmotif::compare_motifs details
#' 
#' @returns A list of matrices containing the similarity scores between motifs
#' from different groups of sequences. The order of comparison is as follows,
#' with first element representing the rows and second element representing the
#' columns of the matrix:
#' \itemize{
#'     \item 1. \strong{Common motifs comparison:} Common seqs from reference
#'     (1) <-> comparison (2)
#'     \item 2. \strong{Unique motifs comparison:} Unique seqs from reference
#'     (1) <-> comparison (2)
#'     \item 3. \strong{Cross motifs comparison 1:} Unique seqs from reference
#'     (1) <-> comparison (1)
#'     \item 4. \strong{Cross motifs comparison 2:} Unique seqs from comparison
#'     (2) <-> reference (1)
#' }
#' The list is repeated for each set of comparison groups in input.
#' 
#' @examples
#' data("CTCF_TIP_peaks", package = "MotifPeeker")
#' data("CTCF_ChIP_peaks", package = "MotifPeeker")
#' 
#' if (requireNamespace("BSgenome.Hsapiens.UCSC.hg38")) {
#'     genome_build <- BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
#'     segregated_peaks <- segregate_seqs(CTCF_TIP_peaks, CTCF_ChIP_peaks)
#'     denovo_motifs <- denovo_motifs(unlist(segregated_peaks),
#'                         trim_seq_width = 100,
#'                         genome_build = genome_build,
#'                         denovo_motifs = 2,
#'                         filter_n = 6,
#'                         out_dir = tempdir(),
#'                         workers = 1)
#'     similarity_matrices <- motif_similarity(denovo_motifs)
#'     print(similarity_matrices)
#' }
#' 
#' @export
motif_similarity <- function(streme_out,
                            method = "PCC",
                            normalise.scores = TRUE,
                            workers = 1,
                            ...) {
    ## Motif group sequence -   #1 Common seqs - Reference (1)
    ## (4 Groups per            #2 Common seqs - Comparison (2)
    ## comparison pair)         #3 Unique seqs - Reference (1)
    ##                          #4 Unique seqs - Comparison (2)
    group_indices <- rep(seq_len(length(streme_out) / 4), each = 4)
    seg_indices <- rep(seq_len(4), length.out = length(streme_out))
    comparison_groups <- list(c(1, 2), c(3, 4), c(3, 2), c(4, 1))
    
    res <- lapply(
        seq_along(streme_out), function(x) {
            comparison_group <- comparison_groups[[seg_indices[x]]]
            .motifsx <- function(m) {
                    motif_i <- comparison_group[2] +
                        (4 * (group_indices[[x]] - 1))
                    streme_out[[motif_i]]$motif
                }
            m1 <- .motifsx(1)
            m2 <- .motifsx(2)
            if (length(m1) == 0 || length(m2) == 0) return(matrix(NA))
            res_x <- universalmotif::compare_motifs(
                        list(m1, m2),
                        method = method,
                        normalise.scores = normalise.scores,
                        nthreads = workers,
                        ...
                    )
            row_indices <- seq(1, length(m1))
            col_indices <- seq(length(m1) + 1, length(m1) + length(m2))
            
            res_x <- res_x[row_indices, col_indices, drop = FALSE]
            return(res_x)
        }
    )
    
    ## Output: Comparison Pair 1 - 1. common_(1) <-> common_(2)
    ##                             2. unique_(1) <-> unique_(2)
    ##                             3. unique_(1) <-> common_(2) [cross1]
    ##                             4. unique_(2) <-> common_(1) [cross2]
    ##         Comparison Pair 2 - 5. common_(1) <-> common_(2)...
    return(res)
}
