#' Read a motif file
#'
#' \code{read_motif_file()} reads a motif file and converts to a PWM. The
#' function supports multiple motif formats, including "homer", "jaspar",
#' "meme", "transfac" and "uniprobe".
#'
#' @import universalmotif
#'
#' @param motif_file Path to the motif file.
#' @param motif_id ID of the motif (e.g. "MA1930.1").
#' @param file_format Character string specifying the format of the motif file.
#' The options are "homer", "jaspar", "meme", "transfac" and "uniprobe"
#'
#' @returns A \code{universalmotif} motif object.
#'
#' @examples
#' motif_file <- system.file("extdata",
#'                           "motif_MA1930.2.jaspar",
#'                           package = "MotifPeeker")
#' res <- read_motif_file(motif_file = motif_file,
#'                        motif_id = "MA1930.2",
#'                        file_format = "jaspar")
#' print(res)
#'
#' @export
read_motif_file <- function(motif_file,
                            motif_id = "Unknown",
                            file_format) {
    read_functions <- list(
        homer = universalmotif::read_homer,
        jaspar = universalmotif::read_jaspar,
        meme = universalmotif::read_meme,
        transfac = universalmotif::read_transfac,
        uniprobe = universalmotif::read_uniprobe
    )
    
    if (!file_format %in% names(read_functions)) {
        stopper(
            "Unsupported file format. The motif file must be one of",
            "homer, jaspar, meme, transfac or uniprobe."
        )
    }
    read_function <- read_functions[[file_format]]
    motif <- read_function(motif_file)
    
    return(motif) # return universalmotif object
}
