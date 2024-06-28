#' Get parameters for \link[BiocParallel]{BiocParallel}
#' 
#' Get appropriate parameters for \code{BiocParallel} based on the
#' number of workers specified. For less than 4 workers, the function returns a
#' \code{MulticoreParam} object. For 4 or more cores, the function
#' returns a \code{SnowParam} object. Since Windows supports
#' neither, the function returns a \code{SerialParam} object. As a
#' result, Windows users do not benefit from parallel processing.
#' 
#' @param workers The number of workers to use for parallel processing.
#' @param force_snowparam A logical indicating whether to force the use of
#' \link[BiocParallel]{SnowParam} object.
#' @param verbose A logical indicating whether to print verbose messages while
#' running the function. (default = FALSE)
#' @inheritParams BiocParallel::SnowParam
#' 
#' @returns A \code{BPPARAM} object.
#'
#' @seealso \link[BiocParallel]{BiocParallelParam}
#' 
#' @keywords internal
get_bpparam <- function(workers,
                        progressbar = workers > 1,
                        force_snowparam = FALSE,
                        verbose = FALSE) {
    if (.Platform$OS.type == "windows") {
        custom_bpparam <- BiocParallel::SerialParam()
        messager("Windows does not support parallel processing.",
                "Returning SerialParam object for BiocParallel.",
                v = verbose)
    } else if (workers < 4 && !force_snowparam) {
        custom_bpparam <- 
            BiocParallel::MulticoreParam(workers = workers,
                                        progressbar = progressbar)
        messager("Using MulticoreParam object for BiocParallel (workers =",
                paste0(workers, ")."), v = verbose)
    } else {
        custom_bpparam <- BiocParallel::SnowParam(workers = workers,
                                                    progressbar = progressbar)
        messager("Using SnowParam object for BiocParallel (workers =",
                paste0(workers, ")."), v = verbose)
    }
    
    return(custom_bpparam)
}
