#' Get JASPAR link for motifs
#' 
#' @param motif_id A character string specifying the JASPAR motif ID.
#' @param download A logical specifying whether to return a download link or an
#' HTML embeddable matrix profile link. (default = FALSE)
#' 
#' @returns A character string containing the JASPAR motif link. If
#' \code{motif_id} is not a valid JASPAR motif ID, it is returned as is.
#' 
#' @keywords internal
link_JASPAR <- function(motif_id, download = FALSE) {
    if (is.na(motif_id) || !startsWith(motif_id, "MA")) {
        return(motif_id)
    }
    if (download) {
        ## Return download link
        return(paste0("https://jaspar.elixir.no/api/v1/matrix/",
                        motif_id, ".jaspar"))
    } else {
        ## Return HTML embeddable matrix profile link
        return(paste0("<a href='https://jaspar.elixir.no/matrix/", motif_id,
                    "' target='_blank'>", motif_id, "</a>"))
    }
}
