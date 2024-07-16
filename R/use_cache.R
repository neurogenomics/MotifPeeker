#' Check, add and access files in cache
#' 
#' Query local BiocFileCache to get cached version of a file and add them if
#' they do not exist.
#' 
#' @param url A character string specifying the URL of the file to check for.
#' @inheritParams MotifPeeker
#' 
#' @importFrom BiocFileCache BiocFileCache bfcinfo bfcrpath
#' 
#' @returns A character string specifying the path to the cached file.
#' 
#' @keywords internal
use_cache <- function(url, verbose = FALSE) {
    bfc <- BiocFileCache::BiocFileCache(ask = FALSE)
    cached_files <- BiocFileCache::bfcinfo(bfc)$rname
    
    if (!url %in% cached_files) {
        messager("Adding file to cache: ", url, v = verbose)
    }
    return(BiocFileCache::bfcrpath(bfc, url))
}
