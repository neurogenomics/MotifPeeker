#' Apply \code{\link[base]{normalizePath}} to a list of paths
#' 
#' @param path_list A list of paths.
#' 
#' @return A list of normalised paths or the input as is if contents are not
#' a character.
#' 
#' @keywords internal
normalise_paths <- function(path_list) {
    if (all(is.null(path_list))) return(path_list)
    
    ## Convert objects to list if not already
    if (!is.list(path_list) &&(!is.vector(path_list) || length(path_list) == 1))
        path_list <- list(path_list)
    
    ## Return input as is if not character
    if (!all(vapply(path_list, is.character, logical(1)))) return(path_list)
    
    ## Normalise paths
    lapply(path_list, function(path) {
        normalizePath(path)
    })
}
