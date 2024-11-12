#' Discover motifs in sequences
#' 
#' Use STREME from MEME suite to find  motifs in the provided sequences.
#' To speed up the process, the sequences can be optionally trimmed to reduce
#' the search space. The result is then optionally filtered to remove motifs
#' with a high number of nucleotide repeats
#' 
#' @param seqs A list of \code{\link[GenomicRanges]{GRanges}} objects containing
#' sequences to search for motifs.
#' @param trim_seq_width An integer specifying the width of the sequence to
#' extract around the summit (default = NULL). This sequence is used to search
#' for discovered motifs. If not provided, the entire peak region will be used.
#' This parameter is intended to reduce the search space and speed up motif
#' discovery; therefore, a value less than the average peak width is
#' recommended. Peaks are trimmed symmetrically around the summit while
#' respecting the peak bounds.
#' @param discover_motifs_count An integer specifying the number of motifs to
#' discover. (default = 3) Note that higher values take longer to compute.
#' @param minw An integer specifying the minimum width of the motif.
#' (default = 8)
#' @param maxw An integer specifying the maximum width of the motif.
#' (default = 25)
#' @param filter_n An integer specifying the number of consecutive nucleotide
#' repeats a discovered motif must contain to be filtered out.
#' (default = 6)
#' @param out_dir A \code{character} vector of output directory to save STREME
#' results to. (default = \code{tempdir()})
#' @param BPPARAM A \code{\link[BiocParallel]{BiocParallelParam-class}} object
#' specifying run parameters. (default = SerialParam(), single core run)
#' @param debug A logical indicating whether to print debug messages while
#' running the function. (default = FALSE)
#' @param ... Additional arguments to pass to \code{STREME}. For more
#' information, refer to the official MEME Suite documentation on
#' \href{https://meme-suite.org/meme/doc/streme.html}{STREME}.
#' @inheritParams bpapply
#' @inheritParams motif_enrichment
#' 
#' @returns A list of \code{\link[universalmotif]{universalmotif}} objects and
#' associated metadata.
#' 
#' @examples
#' if (memes::meme_is_installed()) {
#' data("CTCF_TIP_peaks", package = "MotifPeeker")
#' if (requireNamespace("BSgenome.Hsapiens.UCSC.hg38", quietly = TRUE)) {
#'     genome_build <- BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
#'    
#'     res <- denovo_motifs(list(CTCF_TIP_peaks),
#'                         trim_seq_width = 50,
#'                         genome_build = genome_build,
#'                         discover_motifs_count = 1,
#'                         filter_n = 6,
#'                         minw = 8,
#'                         maxw = 8,
#'                         out_dir = tempdir())
#'     print(res[[1]]$consensus)
#' }
#' }
#' @export
denovo_motifs <- function(seqs,
                            trim_seq_width,
                            genome_build,
                            discover_motifs_count = 3,
                            minw = 8,
                            maxw = 25,
                            filter_n = 6,
                            out_dir = tempdir(),
                            meme_path = NULL,
                            BPPARAM = BiocParallel::SerialParam(),
                            verbose = FALSE,
                            debug = FALSE,
                            ...) {
    out_dir <- file.path(out_dir, "streme")
    if (!dir.exists(out_dir)) dir.create(out_dir, recursive = TRUE)
    if (!is.list(seqs)) seqs <- list(seqs)
    
    messager("Starting STREME run for", length(seqs), "sets of sequences.",
            v = verbose)
    res <- bpapply(
        seq_along(seqs), function(x) {
            seq_x <- seqs[[x]]
            
            ### Trim sequences ###
            if (!is.null(trim_seq_width)) seq_x <-
                    trim_seqs(seq_x, trim_seq_width, genome_build)
            
            ### Run STREME ###
            seq_fasta <- memes::get_sequence(seq_x, genome_build)
            streme_out <- memes::runStreme(
                input = seq_fasta,
                control = "shuffle",
                outdir = file.path(out_dir, x),
                alph = "dna",
                silent = !debug,
                minw = 8,
                maxw = 25,
                nmotifs = discover_motifs_count,
                meme_path = meme_path,
                ...
            )
            
            ### Filter motifs ###
            out <- filter_repeats(streme_out, filter_n)
            return(out)
        }, BPPARAM = BPPARAM, verbose = verbose
    )
    messager("STREME run complete.", v = verbose)
    return(res)
}
