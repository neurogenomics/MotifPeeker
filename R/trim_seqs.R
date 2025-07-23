#' Trim sequences to a specified width around the summit
#'
#' @param peaks A GRanges object created using
#' \code{\link[=read_peak_file]{read_peak_file()}}.
#' @param peak_width Total expected width of the peak.
#' @param genome_build The genome build that the peak sequences should be
#' derived from.
#' @param respect_bounds Logical indicating whether the peak width should be
#' respected when trimming sequences. (default = TRUE) If \code{TRUE}, the
#' trimmed sequences will not extend beyond the peak boundaries.
#' 
#' @importFrom IRanges IRanges
#' @importFrom GenomicRanges seqnames GRanges strand mcols start end
#' @importFrom Seqinfo seqlengths
#' 
#' @return A GRanges object with the trimmed sequences. The sequences are
#' guaranteed to not exceed the \code{peak width + 1} (peak width + the summit
#' base).
#' 
#' @examples
#' data("CTCF_TIP_peaks", package = "MotifPeeker")
#' peaks <- CTCF_TIP_peaks
#' genome_build <- BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
#' 
#' trimmed_seqs <- MotifPeeker:::trim_seqs(peaks, peak_width = 100,
#'                          genome_build = genome_build)
#' summary(GenomicRanges::width(trimmed_seqs))
#' 
#' @keywords internal
trim_seqs <- function(peaks, peak_width, genome_build, respect_bounds = TRUE) {
    peak_width <- round(peak_width / 2, 0)
    max_len <- Seqinfo::seqlengths(genome_build)[as.character(
        GenomicRanges::seqnames(peaks))]
    
    if (respect_bounds) {
        adjusted_iranges <- IRanges::IRanges(
            ## Ensure start is not less than 1 or more than the sequence length
            start = pmax(peaks$summit - peak_width, 1,
                        GenomicRanges::start(peaks)),
            ## Ensure end is not more than the sequence or peak length
            end = pmin(peaks$summit + peak_width, max_len,
                        GenomicRanges::end(peaks))
        )
    } else {
        adjusted_iranges <- IRanges::IRanges(
            start = pmax(peaks$summit - peak_width, 1),
            end = pmin(peaks$summit + peak_width, max_len)
        )
    }
    
    adjusted_granges <- GenomicRanges::GRanges(
        seqnames = GenomicRanges::seqnames(peaks),
        ranges = adjusted_iranges,
        strand = GenomicRanges::strand(peaks)
    )
    GenomicRanges::mcols(adjusted_granges) <- GenomicRanges::mcols(peaks)
    
    return(adjusted_granges)
}
