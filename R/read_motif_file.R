#' Read a motif file
#'
#' \code{read_motif_file()} reads a motif file and converts to a PWM. The
#' function supports multiple motif formats, including "homer", "jaspar",
#' "meme", "transfac" and "uniprobe".
#'
#' @importFrom universalmotif read_homer read_jaspar read_meme read_transfac
#' read_uniprobe
#' @importFrom tools file_ext
#'
#' @param motif_file Path to a motif file or a
#' \code{\link[universalmotif]{universalmotif-class}} object.
#' @param motif_id ID of the motif (e.g. "MA1930.1").
#' @param file_format Character string specifying the format of the motif file.
#' The options are "homer", "jaspar", "meme", "transfac" and "uniprobe"
#' @param verbose A logical indicating whether to print messages.
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
                            file_format = "auto",
                            verbose = FALSE) {
    ### Check if motif_file is a universalmotif object ###
    if (inherits(motif_file, "universalmotif")) {
        return(motif_file)
    }
    
    ### Load supported read functions ###
    read_functions <- list(
        homer = universalmotif::read_homer,
        jaspar = universalmotif::read_jaspar,
        meme = universalmotif::read_meme,
        transfac = universalmotif::read_transfac,
        uniprobe = universalmotif::read_uniprobe
    )

    ### Infer file format ###
    file_format <- tolower(file_format)
    if (file_format == "auto") {
        file_ext <- tolower(tools::file_ext(motif_file))
        if (file_ext %in% names(read_functions)) {
            file_format <- file_ext
            messager(paste0("Auto-inferred motif file format as ",
                    shQuote(file_format), "."),
                    v = verbose)
        }
    }
    
    ### Read motif file ###
    if (!file_format %in% names(read_functions)) {
        stp_msg <- paste("Unsupported file format. The motif file must be one",
                        "of homer, jaspar, meme, transfac or uniprobe.")
        stop(stp_msg)
    }
    read_function <- read_functions[[file_format]]
    motif <- read_function(motif_file)
    
    return(motif) # Return universalmotif object
}
