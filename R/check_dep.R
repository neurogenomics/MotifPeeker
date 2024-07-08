#' Check attached dependency
#' 
#' Stop execution if a package is not attached.
#' 
#' @param pkg a character string of the package name
#' @param fatal a logical value indicating whether to stop execution if the
#' package is not attached.
#' @param custom_msg a custom message to display if the package is not attached.
#' 
#' @return Null
#' 
#' @keywords internal
check_dep <- function(pkg, fatal = TRUE, custom_msg = NULL){
    if (is.null(custom_msg)) {
        custom_msg <- paste("Package", shQuote(pkg), "is required to run this",
                            "function.")
    }
    if (!requireNamespace(pkg, quietly = TRUE)) {
        if (fatal) {
            stop(custom_msg)
        } else {
            warning(custom_msg)
        }
    }
}
