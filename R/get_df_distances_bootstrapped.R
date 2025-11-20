#' Get dataframe with bootstrapped motif-summit distances
#' 
#' Wrapper for `MotifPeeker::bootstrap_distances` to get bootstrapped
#' motif-summit distances for given peaks and motifs, generating a
#' \code{data.frame} suitable for plots.
#' 
#' @inheritParams get_df_distances
#' @inheritParams bootstrap_distances
#' 
#' @returns A \code{data.frame} with the following columns:
#' \describe{
#'  \item{exp_label}{Experiment labels.}
#'  \item{exp_type}{Experiment types.}
#'  \item{motif_indice}{Motif indices.}
#'  \item{bootstrap_iteration}{Bootstrap iteration number.}
#'  \item{distance}{Mean of absolute distances between peak summit and motif.}
#' }
#'
#' @examples
#' if (memes::meme_is_installed()) {
#'     peak <- system.file("extdata", "CTCF_ChIP_peaks.narrowPeak",
#'                 package = "MotifPeeker") |>
#'                 read_peak_file() |>
#'                 sample(20)
#'     motif_MA1102.3 <- system.file("extdata", "motif_MA1102.3.jaspar",
#'                 package = "MotifPeeker") |> read_motif_file()
#'     motif_MA1930.2 <- system.file("extdata", "motif_MA1930.2.jaspar",
#'                 package = "MotifPeeker") |> read_motif_file()
#'
#'     input <- list(
#'         peaks = peak,
#'         exp_type = "ChIP",
#'         exp_labels = "CTCF",
#'         read_count = 150,
#'         peak_count = 100
#'     )
#'     motifs <- list(
#'         motifs = list(motif_MA1930.2, motif_MA1102.3),
#'         motif_labels = list("MA1930.2", "MA1102.3")
#'     )
#'                 
#'     if (requireNamespace("BSgenome.Hsapiens.UCSC.hg38")) {
#'         genome_build <-
#'             BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
#'             
#'         distances_df_bootstrapped <- get_df_distances_bootstrapped(
#'             input,
#'             user_motifs = motifs,
#'             genome_build = genome_build,
#'             samples_n = NULL,
#'             samples_len = NULL,
#'             verbose = FALSE
#'         )
#'         print(distances_df_bootstrapped)
#'     }
#' }
#' 
#' @family generate data.frames
#' 
#' @export
get_df_distances_bootstrapped <- function(result,
                                          user_motifs,
                                          genome_build,
                                          samples_n = NULL,
                                          samples_len = NULL,
                                          out_dir = tempdir(),
                                          BPPARAM = BiocParallel::bpparam(),
                                          meme_path = NULL,
                                          verbose = FALSE) {
    if (!is.list(result$peaks)) result$peaks <- list(result$peaks)
    result_len <- length(result$peaks)
    motif_len <- length(user_motifs$motifs)
    
    if (result_len == 0 || motif_len == 0) return (list())
    
    peak_combinations <- rep(result$peaks, each = motif_len)
    exp_label_combinations <- rep(result$exp_labels, each = motif_len)
    exp_type_combinations <- rep(result$exp_type, each = motif_len)
    motif_combinations <- rep(user_motifs$motifs, result_len)
    
    # Setup samples_n, samples_len
    min_peaks <- min(sapply(peak_combinations, length))
    if (is.null(samples_n)) {
        samples_n <- max(round(min_peaks * 0.7), 100)
    }
    if (is.null(samples_len)) {
        samples_len <- max(round(min_peaks / 5), 10)
    }
    
    distances_bootstrapped <- bpapply(
        seq_len(result_len * motif_len), function(i) {
        peakset <- peak_combinations[[i]]
        motif <- motif_combinations[[i]]
            
        distances <- bootstrap_distances(
            peaks = peakset,
            motif = motif,
            genome_build = genome_build,
            samples_n = samples_n,
            samples_len = samples_len,
            out_dir = out_dir,
            meme_path = meme_path,
            verbose = verbose
        )
        
        data.frame(
            exp_label = exp_label_combinations[i],
            exp_type = exp_type_combinations[i],
            motif_indice = rep(seq_len(motif_len), result_len)[i],
            bootstrap_iteration = seq_len(length(distances)),
            distance = distances
        )
    }, BPPARAM = BPPARAM, verbose = verbose) %>% dplyr::bind_rows()
    return(distances_bootstrapped)
}
