#' Find similar motifs
#' 
#' Search through provided motif database to find similar motifs to the input.
#' Light wrapper around \code{TOMTOM} from MEME Suite.
#' 
#' @param streme_out Output from \code{\link{denovo_motifs}}.
#' @param motif_db Path to \code{.meme} format file to use as reference
#' database, or a list of \code{\link[universalmotif]{universalmotif-class}}
#' objects. (optional) Results from de-novo motif discovery are searched against
#' this database to find similar motifs. If not provided, JASPAR CORE database
#' will be used. \strong{NOTE}: p-value estimates are inaccurate when the
#' database has fewer than 50 entries.
#' @param ... Additional arguments to pass to \code{TOMTOM}. For more
#' information, refer to the official MEME Suite documentation on
#' \href{https://meme-suite.org/meme/doc/tomtom.html}{TOMTOM}.
#' @inheritParams denovo_motifs
#' 
#' @importFrom memes runTomTom
#' 
#' @inherit memes::runTomTom return
#' 
#' @examples
#' data("CTCF_TIP_peaks", package = "MotifPeeker")
#' if (requireNamespace("BSgenome.Hsapiens.UCSC.hg38", quietly = TRUE)) {
#'     genome_build <- BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
#'    
#'     res <- denovo_motifs(list(CTCF_TIP_peaks),
#'                         trim_seq_width = 100,
#'                         genome_build = genome_build,
#'                         denovo_motifs = 2,
#'                         filter_n = 6,
#'                         out_dir = tempdir())
#'     res2 <- find_motifs(res, motif_db = get_JASPARCORE(),
#'                         out_dir = tempdir())
#'     print(res2)
#' }
#' 
#' @export
find_motifs <- function(streme_out,
                        motif_db,
                        out_dir = tempdir(),
                        meme_path = NULL,
                        workers = 1,
                        verbose = FALSE,
                        debug = FALSE,
                        ...) {
    out_dir <- file.path(out_dir, "tomtom")
    if (!dir.exists(out_dir)) dir.create(out_dir, recursive = TRUE)
    
    res <- bpapply(
        seq_along(streme_out), function(x) {
            motifs <- streme_out[[x]]$motif
            lapply(seq_along(motifs), function(y) {
                out_dir_x <- file.path(out_dir, x, y)
                if (!dir.exists(out_dir_x)) dir.create(out_dir_x,
                                                        recursive = TRUE)
                res_x <- memes::runTomTom(
                    motifs[[y]], motif_db, outdir = out_dir_x, silent = !debug,
                    meme_path = meme_path, ...
                )
                return(res_x)
            })
        }, workers = workers, verbose = verbose
    )
    return(res)
}
