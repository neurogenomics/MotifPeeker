#' Check for JASPAR input
#' 
#' Check and get files from JASPAR. Requires the input to be in JASPAR
#' ID format. Uses BiocFileCache to cache downloads.
#' 
#' @inheritParams link_JASPAR
#' @inheritParams MotifPeeker
#' 
#' @returns A character string specifying the path to the downloaded file.
#' 
#' @examples
#' check_JASPAR("MA1930.2")
#' 
#' @export
check_JASPAR <- function(motif_id, verbose = FALSE) {
    ### Validate JASPAR ID ###
    stp_msg <- "Input is not a JASPAR ID string."
    if (!(is.character(motif_id) && startsWith(motif_id, "MA"))) stop(stp_msg)
    
    ### Fetch file ###
    return(use_cache(link_JASPAR(motif_id, download = TRUE), verbose = verbose))
}

