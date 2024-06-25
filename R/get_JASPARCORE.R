#' Download JASPAR CORE database
#' 
#' Downloads JASPAR CORE database in \code{meme} format for all available
#' taxonomic groups. Uses BiocFileCache to cache downloads.
#' 
#' @inheritParams MotifPeeker
#' 
#' @returns A character string specifying the path to the downloaded file
#' (\code{meme} format).
#' 
#' @examples
#' get_JASPARCORE()
#' 
#' @export
get_JASPARCORE <- function(verbose = FALSE) {
    core_url <- "https://jaspar.elixir.no/download/data/2024/CORE/JASPAR2024_CORE_non-redundant_pfms_meme.txt"
    return(use_cache(core_url, verbose = verbose))
}
