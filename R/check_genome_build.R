#' Check genome build
#' 
#' Check if the genome build is valid and return the appropriate BSGenome
#' object.
#' 
#' At the moment, only \code{hg38} and \code{hg19} are supported as
#' abbreviated input.
#' 
#' @param genome_input A character string with the abbreviated genome build
#' name, or a BSGenome object. At the moment, only \code{hg38} and \code{hg19}
#' are supported as abbreviated input.
#' @returns A BSGenome object.
#' @importFrom methods is
#' @seealso \link[BSgenome]{BSgenome-class} for more information on BSGenome
#' objects.
#' @examples
#' if (requireNamespace("BSgenome.Hsapiens.UCSC.hg38", quietly = TRUE)) {
#'     check_genome_build("hg38")
#' }
#' @export
check_genome_build <- function(genome_input) {
    if (methods::is(genome_input, "BSgenome")) {
        return(genome_input)
    }
    if (is.character(genome_input) &&
        genome_input %in% c("hg38", "hg19")) {
            genome <- paste0("BSgenome.Hsapiens.UCSC.", genome_input)
            check_dep(genome)
            return(get(genome, envir = asNamespace(genome)))
    }
    stopper(paste0(
        "Could not recognise genome build ",
        shQuote(genome_input),
        ". ",
        "Try passing a BSgenome object."
    ))
}
