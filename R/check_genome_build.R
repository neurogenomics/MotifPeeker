#' Check genome build
#' 
#' Check if the genome build is valid and return an appropriate
#' \link[BSgenome]{BSgenome-class} object.
#' 
#' @param genome_build A character string with the abbreviated genome build
#' name, or a BSGenome object. Check \link{check_genome_build} details for
#' genome builds which can be imported as abbreviated names.
#' 
#' @details Currently, the following genome builds can be specified to
#' `genome_build` as abbreviated names:
#' 
#' \itemize{
#'    \item \code{hg38}: Human genome build GRCh38
#'    (BSgenome.Hsapiens.UCSC.hg38)
#'    \item \code{hg19}: Human genome build GRCh37
#'    (BSgenome.Hsapiens.UCSC.hg19)
#'    \item \code{mm10}: Mouse genome build GRCm38
#'    (BSgenome.Mmusculus.UCSC.mm10)
#'    \item \code{mm39}: Mouse genome build GRCm39
#'    (BSgenome.Mmusculus.UCSC.mm39)
#' }
#' 
#' 
#' If the genome build you wish to use is not listed here, please pass a
#' \link[BSgenome]{BSgenome-class} data object directly.
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
    if (is.character(genome_build)) {
        genome <- switch(genome_build,
                         "hg38" = "BSgenome.Hsapiens.UCSC.hg38",
                         "hg19" = "BSgenome.Hsapiens.UCSC.hg19",
                         "mm10" = "BSgenome.Mmusculus.UCSC.mm10",
                         "mm39" = "BSgenome.Mmusculus.UCSC.mm39",
                         NULL
        )
        
        if (!is.null(genome)) {
            check_dep(genome)
            return(get(genome, envir = asNamespace(genome)))
        }
    }
    stp_msg <- paste0(
        "Could not recognise genome build ",
        shQuote(genome_build),
        ". ",
        "Try passing a BSgenome object."
    )
    stop(stp_msg)
}
