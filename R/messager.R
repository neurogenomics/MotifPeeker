#' Print messages 
#' 
#' Conditionally print messages.
#'  Allows developers to easily control verbosity of functions, 
#'  and meet Bioconductor requirements that dictate the message 
#'  must first be stored to a variable before passing to \link[base]{message}. 
#'  
#' 
#' @param v Whether to print messages or not.
#' @param parallel Whether to enable message print when wrapped 
#' in parallelised functions.
#' 
#' @return Null
#' 
#' @keywords internal 
messager <- function(...,
                    v = Sys.getenv("VERBOSE") != "FALSE", 
                    parallel = TRUE) {
    msg <- paste(...)
    
    message_parallel <- function(...) {
        system2("echo", args = paste0(..., collpase = ""))
    }
    if(isTRUE(parallel)){
        if(v) try({message_parallel(msg)})
    } else {
        if (v) try({message(msg)})
    }
}
