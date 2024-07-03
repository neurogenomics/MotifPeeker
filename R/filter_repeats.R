#' Filter motifs with nucleotide repeats
#' 
#' Filter out motifs which contain \code{filter_n} or more consecutive
#' nucleotide repeats. This includes unambiguous bases such as 'Y', 'N, 'R',
#' etc.
#' 
#' @param motifs Output from \code{\link[memes]{runStreme}}.
#' @param filter_n Minimum number of consecutive nucleotide repeats to filter.
#' 
#' @returns A list object with same structure as \code{motifs} but with motifs
#' containing \code{filter_n} or more consecutive nucleotide repeats removed.
#' 
#' @seealso \code{\link[memes]{runStreme}}
#' 
#' @keywords internal
filter_repeats <- function(motifs, filter_n = 6) {
    if (is.null(filter_n) || filter_n < 1) return(motifs)
    
    if (filter_n < 4) {
        warn_msg <- paste("It is not recommended to filter out motifs with",
        "less than 4 consecutive nucleotide repeats.")
        warning(warn_msg)
    }
    
    repeat_pattern <- paste0("([A-Z])\\1{", filter_n - 1, ",}")
    good_motif_indices <- vapply(seq_along(motifs$consensus), function(i) {
        if (!grepl(repeat_pattern, motifs$consensus[i])) {
            return(i)
        } else {
            return(-1)
        }
    }, numeric(1))
    good_motif_indices <- good_motif_indices[good_motif_indices != -1]
    filtered_motifs <- motifs[good_motif_indices,]
    return(filtered_motifs)
}
