#' Check attached dependency
#' 
#' Stop execution if a package is not attached.
#' 
#' @param pkg a character string of the package name
#' 
#' @return NULL
#' @keywords internal
check_dep <- function(pkg){
    if (!requireNamespace(pkg, quietly = TRUE)) {
        stp_msg <- paste("Package", shQuote(pkg), "is required to run this",
                          "function.")
        stop(stp_msg)
    }
}
