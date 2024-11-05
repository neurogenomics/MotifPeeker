#' Check for input validity and pass to appropriate function
#' 
#' @param x The input to check.
#' @param type The type of input to check for. Supported types are:
#' \itemize{
#'  \item \code{jaspar_id}: JASPAR identifier.
#'  \item \code{motif}: `universalmotif` motif object.
#'  \item \code{encode_id}: ENCODE identifier.
#' }
#' @param FUN The function to pass the input to.
#' @param inverse Logical indicating whether to return the input if it is
#' invalid for the specified `type`.
#' @param ... Additional arguments to pass to the `FUN` function.
#' 
#' @returns `x` if the input is invalid for the specified `type`, or else the
#' output of the `FUN` function. If `inverse = TRUE`, the function returns the
#' output of the `FUN` function if the input is valid, or else `x`.
#' 
#' @keywords internal
check_input <- function(x, type, FUN, inverse = FALSE, ...) {
    valid <- switch(
        tolower(type),
        jaspar_id = is.character(x) && startsWith(x, "MA"),
        encode_id = {
            id_pattern <- "^ENC(SR|BS|DO|GM|AB|LB|FF|PL)\\d{3}[A-Z]{3}$"
            all(is.character(x)) && all(grepl(id_pattern, x))
        },
        motif = inherits(x, "universalmotif"),
        stop("Invalid type specified.")
    )
    
    if (inverse) ifelse(valid, return(x), return(FUN(x, ...)))
    ifelse(valid, return(FUN(x, ...)), return(x))
}
