#' Format exp_type
#' 
#' Format input exp_type to look pretty.
#' 
#' @param exp_type A character depicting the type of experiment.
#' Supported experimental types are:
#' \itemize{
#'   \item \code{chipseq}: ChIP-seq data
#'   \item \code{tipseq}: TIP-seq data
#'   \item \code{cuttag}: CUT&Tag data
#'   \item \code{cutrun}: CUT&Run data
#'   \item \code{other}: Other experiment type data
#'   \item \code{unknown}: Unknown experiment type data
#' }
#' Any item not mentioned above will be returned as-is.
#' 
#' @return A character vector of formatted exp_type.
#' 
#' @examples
#' format_exptype("chipseq")
#' 
#' @export
format_exptype <- function(exp_type) {
    if (is.na(exp_type)) {
        exp_type <- "unknown"
    }
    
    exp_type <- tolower(exp_type)
    exp_types <- c(
        "tipseq" = "TIP-Seq",
        "chipseq" = "ChIP-Seq",
        "cutrun" = "CUT&RUN",
        "cuttag" = "CUT&Tag",
        "other" = "Other",
        "unknown" = "Unknown"
    )
    
    if (!exp_type %in% names(exp_types)) {
        return(exp_type)
    }
    
    exp_type <- exp_types[[exp_type]]
    return(exp_type)
}
