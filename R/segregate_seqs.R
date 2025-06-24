#' Segregate input sequences into common and unique groups
#' 
#' This function takes two sets of sequences and segregates them into common and
#' unique sequences. The common sequences are sequences that are present in both
#' sets of sequences. The unique sequences are sequences that are present in
#' only one of the sets of sequences.
#' 
#' Sequences are considered common if their base pairs align in any
#' position, even if they vary in length. Consequently, while the number of
#' common sequences remains consistent between both sets, but the length and
#' composition of these sequences may differ. As a result, the function returns
#' distinct sets of common sequences for each input set of sequences.
#' 
#' @param seqs1 A set of sequences (\code{GRanges} object)
#' @param seqs2 A set of sequences (\code{GRanges} object)
#' 
#' @importFrom GenomicRanges findOverlaps
#' @importFrom S4Vectors queryHits subjectHits
#' 
#' @returns A list containing the common sequences and unique sequences for each
#' set of sequences. The list contains the following \code{GRanges} objects:
#' \itemize{
#'     \item \code{common_seqs1}: Common sequences in \code{seqs1}
#'     \item \code{common_seqs2}: Common sequences in \code{seqs2}
#'     \item \code{unique_seqs1}: Unique sequences in \code{seqs1}
#'     \item \code{unique_seqs2}: Unique sequences in \code{seqs2}
#' }
#' 
#' @examples
#' data("CTCF_ChIP_peaks", package = "MotifPeeker")
#' data("CTCF_TIP_peaks", package = "MotifPeeker")
#' 
#' seqs1 <- CTCF_ChIP_peaks
#' seqs2 <- CTCF_TIP_peaks
#' res <- segregate_seqs(seqs1, seqs2)
#' print(res)
#' 
#' @seealso \link[GenomicRanges]{findOverlaps}
#' 
#' @export
segregate_seqs <- function(seqs1, seqs2) {
    common_seqs_ranges <- GenomicRanges::findOverlaps(seqs1, seqs2,
                                                        type = "any")
    
    common_seqs1 <- seqs1[S4Vectors::queryHits(common_seqs_ranges)]
    common_seqs2 <- seqs2[S4Vectors::subjectHits(common_seqs_ranges)]
    unique_seqs1 <- seqs1[-S4Vectors::queryHits(common_seqs_ranges)]
    unique_seqs2 <- seqs2[-S4Vectors::subjectHits(common_seqs_ranges)]
    
    return(
        list(
            common_seqs1 = unique(common_seqs1),
            common_seqs2 = unique(common_seqs2),
            unique_seqs1 = unique(unique_seqs1),
            unique_seqs2 = unique(unique_seqs2)
        )
    )
}
