#' Bootstrap motif-summit distances for one set of peaks and one motif
#' 
#' This function performs bootstrapping to estimate the distribution of mean
#' absolute distances between peak summits and motif positions for a given set
#' of peaks and a specified motif.
#' 
#' @param peaks A \code{GRanges} object containing peak ranges.
#' @param motif A \code{universalmotif} object.
#' @param genome_build A \code{BSgenome} object representing the genome build.
#' @param samples_n An integer specifying the number of bootstrap samples to
#' generate. If \code{NULL}, it is set to 70\% of the number of peaks.
#' @param samples_len An integer specifying the number of peaks to sample in
#' each bootstrap iteration. If \code{NULL}, it is set to 20% of the number of
#' peaks.
#' @inheritParams summit_to_motif
#' 
#' @importFrom dplyr bind_rows
#' 
#' @returns A \code{numeric} vector of bootstrapped mean absolute distances
#' between peak summits and motif positions with length equal to
#' \code{samples_n}.
#'
#' @examples
#' if (memes::meme_is_installed()) {
#'     peak <- system.file("extdata", "CTCF_ChIP_peaks.narrowPeak",
#'                 package = "MotifPeeker") |>
#'                 read_peak_file() |>
#'                 sample(20)
#'     motif <- system.file("extdata", "motif_MA1102.3.jaspar",
#'                 package = "MotifPeeker") |> read_motif_file()
#'                 
#'     if (requireNamespace("BSgenome.Hsapiens.UCSC.hg38")) {
#'         genome_build <-
#'             BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
#'             
#'         distances <- bootstrap_distances(
#'             peak = peak,
#'             motif = motif,
#'             genome_build = genome_build,
#'             samples_n = 2,
#'             samples_len = NULL,
#'             verbose = FALSE
#'         )
#'         print(distances)
#'     }
#' }
#' 
#' @export
bootstrap_distances <- function(peaks,
                                motif,
                                genome_build,
                                samples_n = NULL,
                                samples_len = NULL,
                                out_dir = tempdir(),
                                meme_path = NULL,
                                verbose = FALSE) {
    # Check input
    if (!inherits(peaks, "GRanges")) {
        stop("peaks must be a GRanges object.")
    }
    if (!inherits(motif, "universalmotif")) {
        stop("motif must be a universalmotif object.")
    }
    
    # Setup samples_n, samples_len
    if (is.null(samples_n)) {
        messager("Setting samples_n to number of peaks for bootstrapping",
                 "motif-summit distances:", length(peaks),
                v = verbose)
        samples_n <- max(round(length(peaks) * 0.7), 10)
    }
    if (is.null(samples_len)) {
        messager("Setting samples_len to 1000 for bootstrapping",
                 "motif-summit distances.",
                v = verbose)
        samples_len <- max(round(length(peaks)/5), 2)
    }
    
    if (samples_len > length(peaks)) {
        stop("samples_len (", samples_len, ") cannot be greater than ",
             "the number of peaks (", length(peaks), ") for bootstrapping.")
    }
    
    # Bootstrap
    distances <- vapply(
        seq_len(samples_n),
        function(i) {
            sampled_peaks <- sample(peaks, samples_len)
            
            distances <- summit_to_motif(
                sampled_peaks, motif,
                genome_build = genome_build,
                out_dir = file.path(out_dir, "fimo_bootstrap", 
                                    random_string(5), i),
                meme_path = meme_path,
                verbose = verbose
            )$distance_to_summit
            
            # Get mean of absolute distances
            if (length(distances) == 0) return(NA_real_)
            mean(abs(distances))
        },
        numeric(1)
    )
    return(distances)
}