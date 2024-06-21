#' Check genome build
#' 
#' Check if the genome build is valid and return the appropriate BSGenome
#' object.
#' 
#' @param genome_build A character string with the abbreviated genome build
#' name, or a BSGenome object. At the moment, only \code{hg38} and \code{hg19}
#' are supported as abbreviated input.
#' 
#' @returns A BSGenome object.
#' 
#' @seealso \link[BSgenome]{BSgenome-class} for more information on BSGenome
#' objects.
#' 
#' @examples
#' if (requireNamespace("BSgenome.Hsapiens.UCSC.hg38", quietly = TRUE)) {
#'     check_genome_build("hg38")
#' }
#' 
#' @export
check_genome_build <- function(genome_build) {
    if (inherits(genome_build, "BSgenome")) {
        return(genome_build)
    }
    if (is.character(genome_build) &&
        genome_build %in% c("hg38", "hg19")) {
            genome <- paste0("BSgenome.Hsapiens.UCSC.", genome_build)
            check_dep(genome)
            return(get(genome, envir = asNamespace(genome)))
    }
    stp_msg <- paste0(
        "Could not recognise genome build ",
        shQuote(genome_build),
        ". ",
        "Try passing a BSgenome object."
    )
    stopper(stp_msg)
}
