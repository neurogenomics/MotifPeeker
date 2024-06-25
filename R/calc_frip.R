#' Calculate FRiP score
#' 
#' Calculate the Fraction of Reads in Peak score from the read and peak file
#' of an experiment.
#' 
#' The FRiP score is calculated as follows:
#' \deqn{\text{FRiP} = \frac{(\text{number of reads in peaks})}{\text{(total number of reads)}}}
#' 
#' @param read_file A BamFile object.
#' @param peak_file A GRanges object.
#' @param single_end A logical value. If TRUE, the reads classified as
#' single-ended. (default = TRUE)
#' @param total_reads (optional) The total number of reads in the experiment.
#' Skips counting the total number of reads if provided, saving computation.
#' 
#' @importFrom GenomicAlignments summarizeOverlaps
#' @importFrom SummarizedExperiment assay
#' @importFrom Rsamtools countBam
#' 
#' @returns A numeric value indicating the FRiP score.
#' 
#' @examples
#' read_file <- system.file("extdata", "CTCF_ChIP_alignment.bam",
#'                         package = "MotifPeeker")
#' read_file <- Rsamtools::BamFile(read_file)
#' data("CTCF_ChIP_peaks", package = "MotifPeeker")
#' 
#' calc_frip(read_file, CTCF_ChIP_peaks)
#' 
#' @export
calc_frip <- function(
        read_file,
        peak_file,
        single_end = TRUE,
        total_reads = NULL
) {
    overlaps <-
        GenomicAlignments::summarizeOverlaps(peak_file,
                                            read_file,
                                            singleEnd = single_end,
                                            ignore.strand = TRUE)
    peak_reads <- sum(SummarizedExperiment::assay(overlaps))
    
    if (is.null(total_reads)) {
        total_reads <- Rsamtools::countBam(read_file)$records
    }
    
    return(peak_reads / total_reads)
}
