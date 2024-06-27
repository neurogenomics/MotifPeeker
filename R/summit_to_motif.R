#' Calculate the distance between peak summits and motifs
#'
#' \code{summit_to_motif()} calculates the distance between each motif and its
#' nearest peak summit. \code{runFimo} from the \code{memes} package is used to
#' recover the locations of each motif.
#'
#' This function is designed to work with narrowPeak files from MACS2/3.
#'
#' To calculate the p-value threshold for a desired false-positive rate, we use
#' the approximate formula:
#' \deqn{p \approx \frac{fp\_rate}{2 \times \text{average peak width}}}
#' (Dervied from
#' \href{https://meme-suite.org/meme/doc/fimo-tutorial.html}{FIMO documentation})
#'
#' @param fp_rate The desired false-positive rate. A p-value threshold will be
#' selected based on this value. The default false-positive rate is
#' 0.05.
#' @param out_dir Location to save the 0-order background file. By default, the
#' background file will be written to a temporary directory.
#' @param verbose A logical indicating whether to print verbose messages while
#' running the function. (default = FALSE)
#' @inheritParams motif_enrichment
#' @inheritParams memes::runFimo
#' @inheritDotParams memes::runFimo -sequences -motifs -outdir -bfile
#' 
#' @importFrom BSgenome getSeq
#' @importFrom GenomicRanges width seqnames start end mcols
#' @importFrom memes runFimo
#'
#' @returns A list containing an expanded GRanges peak object with metadata
#' columns relating to motif positions along with a vector of summit-to-motif
#' distances for each valid peak.
#'
#' @examples
#' data("CTCF_TIP_peaks", package = "MotifPeeker")
#' data("motif_MA1102.3", package = "MotifPeeker")
#' 
#' res <- summit_to_motif(
#'     peak_input = CTCF_TIP_peaks,
#'     motif = motif_MA1102.3,
#'     fp_rate = 5e-02,
#'     genome_build = BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
#' )
#' print(res)
#'
#' @seealso \code{\link[memes]{runAme}}
#' 
#' @export
summit_to_motif <- function(peak_input,
                            motif,
                            fp_rate = 5e-02,
                            genome_build,
                            out_dir = tempdir(),
                            meme_path = NULL,
                            verbose = FALSE,
                            ...) {
    peaks <- peak_input # Backwards compatibility
    peak_sequences <- BSgenome::getSeq(genome_build, peak_input)
    
    ## Generate background model
    bfile <- markov_background_model(sequences = peak_sequences,
                                    out_dir = out_dir,
                                    verbose = verbose)
    
    ## p-value calculation for desired fp_rate
    fimo_threshold <- fp_rate / (2 * mean(GenomicRanges::width(peaks)))
    messager("The p-value threshold for motif scanning with FIMO is",
            fimo_threshold, v = verbose)
    fimo_df <- memes::runFimo(sequences = peak_sequences,
                                motifs = motif,
                                bfile = bfile,
                                thresh = fimo_threshold,
                                meme_path = meme_path,
                                ...)
    
    ## Return NULL lists if no FIMO matches are detected
    if (is.null(fimo_df)) return(
        list(peak_set = NULL,
            distance_to_summit = NULL)
    )
    
    index_to_repeat <- base::match(as.vector(GenomicRanges::seqnames(fimo_df)),
                                    names(peaks))
    expanded_peaks <- peaks[index_to_repeat]
    
    ## Calculate motif start and end points
    GenomicRanges::mcols(expanded_peaks)$motif_start <-
        GenomicRanges::start(expanded_peaks) + GenomicRanges::start(fimo_df)
    GenomicRanges::mcols(expanded_peaks)$motif_end <-
        GenomicRanges::start(expanded_peaks) + GenomicRanges::end(fimo_df)
    
    ## Calculate motif centre and distance from centre to summit
    motif_centre <-
        (GenomicRanges::mcols(expanded_peaks)$motif_start +
            GenomicRanges::mcols(expanded_peaks)$motif_end) / 2
    distance_to_summit <-
        (GenomicRanges::mcols(expanded_peaks)$summit - motif_centre)
    
    GenomicRanges::mcols(expanded_peaks)$distance_to_summit <-
        distance_to_summit
    
    return(list(peak_set = expanded_peaks,
                distance_to_summit = distance_to_summit))
}
