#' Use BiocParallel functions with appropriate parameters
#' 
#' Light wrapper around \code{\link[BiocParallel]{BiocParallel}} functions that
#' automatically applies appropriate parallel function.
#' 
#' @param apply_fun A \code{\link[BiocParallel]{BiocParallel}} function to use
#' for parallel processing. (default = \code{BiocParallel::bplapply})
#' @param BPPARAM A \code{\link[BiocParallel]{BiocParallelParam-class}} object
#' specifying run parameters. (default = bpparam())
#' @inheritParams BiocParallel::bplapply
#' @inheritDotParams BiocParallel::bplapply
#' @inheritDotParams BiocParallel::bpmapply
#' 
#' @import BiocParallel
#' 
#' @returns Output relevant to the \code{apply_fun} specified.
#' 
#' @examples
#' half_it <- function(arg1) return(arg1 / 2)
#' x <- seq_len(10)
#' 
#' res <- MotifPeeker:::bpapply(x, half_it)
#' print(res)
#' 
#' @keywords internal
bpapply <- function(
        X,
        FUN,
        apply_fun = BiocParallel::bplapply,
        BPPARAM = BiocParallel::bpparam(),
        progressbar = FALSE,
        force_snowparam = FALSE,
        verbose = FALSE,
        ...
) {
    stp_msg <- paste("Supplied apply_fun is not a valid BiocParallel function.")
    apply_fun_package <- attr(apply_fun, "package")
    if (length(apply_fun_package) == 0 ||
        apply_fun_package != "BiocParallel")  stop(stp_msg)
    
    res <- apply_fun(X, FUN = FUN, BPPARAM = BPPARAM, ...)
    return(res)
}
