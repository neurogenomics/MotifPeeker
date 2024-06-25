#' Check for JASPAR input
#' 
#' Check and get files from JASPAR. Requires the input to be in JASPAR
#' ID format. Uses BiocFileCache to cache downloads.
#' 
#' @inheritParams link_JASPAR
#' @inheritParams MotifPeeker
#' 
#' @returns A character string specifying the path to the downloaded file. If
#' the input is not in JASPAR ID format, the input is returned as-is.
#' 
#' @examples
#' check_JASPAR("MA1930.2")
#' 
#' @export
check_JASPAR <- function(motif_id, verbose = FALSE) {
    ### Validate JASPAR ID ###
    if (!is.character(motif_id)) return(motif_id)
    if (!startsWith(motif_id, "MA")) return(motif_id)
    
    ### Fetch file ###
    return(use_cache(link_JASPAR(motif_id, download = TRUE), verbose = verbose))
}
