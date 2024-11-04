#' Get dataframe with motif-summit distances
#'
#' Wrapper for `MotifPeeker::summit_to_motif` to get motif-summit distances
#' for all peaks and motifs, generating a \code{data.frame} suitable
#' for plots.
#'
#' @param result A \code{list} with the following elements:
#' \describe{
#'     \item{peaks}{A \code{list} of peak files generated using
#' \code{\link{read_peak_file}}.}
#'     \item{alignments}{A \code{list} of alignment files.}
#'     \item{exp_type}{A \code{character} vector of experiment types.}
#'     \item{exp_labels}{A \code{character} vector of experiment labels.}
#'     \item{read_count}{A \code{numeric} vector of read counts.}
#'     \item{peak_count}{A \code{numeric} vector of peak counts.}
#' }
#' @param user_motifs A \code{list} with the following elements:
#' \describe{
#'     \item{motifs}{A \code{list} of motif files.}
#'     \item{motif_labels}{A \code{character} vector of motif labels.}
#' }
#' @param out_dir A \code{character} vector of output directory.
#' @inheritParams MotifPeeker
#' @inheritParams bpapply
#' @inheritParams summit_to_motif
#' 
#' @importFrom purrr map_df
#' 
#' @returns A \code{data.frame} with the following columns:
#' \describe{
#'  \item{exp_label}{Experiment labels.}
#'  \item{exp_type}{Experiment types.}
#'  \item{motif_indice}{Motif indices.}
#'  \item{distance}{Distances between peak summit and motif.}
#' }
#' 
#' @examples
#' if (memes::meme_is_installed()) {
#' data("CTCF_ChIP_peaks", package = "MotifPeeker")
#' data("motif_MA1102.3", package = "MotifPeeker")
#' data("motif_MA1930.2", package = "MotifPeeker")
#' input <- list(
#'     peaks = CTCF_ChIP_peaks,
#'     exp_type = "ChIP",
#'     exp_labels = "CTCF",
#'     read_count = 150,
#'     peak_count = 100
#' )
#' motifs <- list(
#'     motifs = list(motif_MA1930.2, motif_MA1102.3),
#'     motif_labels = list("MA1930.2", "MA1102.3")
#' )
#' 
#' if (requireNamespace("BSgenome.Hsapiens.UCSC.hg38")) {
#'     genome_build <- BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
#'     distances_df <- get_df_distances(input, motifs, genome_build, 
#'                          workers = 1)
#'     print(distances_df)
#' }
#' }
#' 
#' @family generate data.frames
#' 
#' @export
get_df_distances <- function(result,
                            user_motifs,
                            genome_build,
                            out_dir = tempdir(),
                            workers = 1,
                            meme_path = NULL,
                            verbose = FALSE) {
    if (!is.list(result$peaks)) result$peaks <- list(result$peaks)
    result_len <- length(result$peaks)
    motif_len <- length(user_motifs$motifs)
    
    peak_combinations <- rep(result$peaks, each = motif_len)
    exp_label_combinations <- rep(result$exp_labels, each = motif_len)
    exp_type_combinations <- rep(result$exp_type, each = motif_len)
    motif_combinations <- rep(user_motifs$motifs, result_len)
    distances_df <- bpapply(
        seq_len(result_len * motif_len),
        function(i) {
            peak <- peak_combinations[[i]]
            motif <- motif_combinations[[i]]
            list(
                exp_label = exp_label_combinations[i],
                exp_type = exp_type_combinations[i],
                motif_indice = rep(seq_len(motif_len), result_len)[i],
                distance = MotifPeeker::summit_to_motif(
                    peak, motif,
                    genome_build = genome_build,
                    out_dir = file.path(out_dir, "fimo", i),
                    meme_path = meme_path,
                    verbose = verbose
                )$distance_to_summit
            )
        },
        workers = workers, verbose = verbose) %>%
        purrr::map_df(as.data.frame)
    
    ## Output: Peak 1 - Motif 1, 2...
    ##         Peak 2 - Motif 1, 2...
    return(distances_df)
}
