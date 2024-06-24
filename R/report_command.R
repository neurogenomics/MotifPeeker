#' Report command
#' 
#' Reconstruct the \code{\link{MotifPeeker}} command from the parameters used to
#' generate the HTML report.
#' 
#' @param params A list of parameters used to generate the HTML report.
#' 
#' @returns A character string containing the reconstructed
#' \code{\link{MotifPeeker}} command.
#' 
#' @examples
#' report_command(params = list(
#'    alignment_files = c("file1.bam", "file2.bam"),
#'    exp_labels = c("exp1", "exp2"),
#'    genome_build = "hg19"))
#' 
#' 
#' @export
report_command <- function(params) {
    tab_spaces <- paste(rep(" ", nchar("MotifPeeker)")), collapse = "")
    
    params_values <- vapply(names(params), function(name) {
        value <- params[[name]]
        if (is.null(value)) {
            value <- "NULL"
        } else if (is.character(value)) {
            if (length(value) > 1) {
                value <- paste0("list(", 
                                paste0('"', value, '"', collapse = ", "), ")")
            } else {
                value <- paste0('"', value, '"')
            }
        } else if (is.numeric(value)) {
            if (length(value) > 1) {
                value <- paste0("list(", 
                                paste0(value, collapse = ", "), ")")
            }
        } else if (is.logical(value)) {
            value <- ifelse(value, "TRUE", "FALSE")
        } else {
            value <- "..."
        }
        paste0(name, " = ", value)
    }, character(1)) |>
        paste(collapse = paste0(",\n", tab_spaces))
    
    cmd <- paste("MotifPeeker(", params_values, ")", sep = "")
    cmd <- paste0("<pre><code class='language-r'>",cmd,"</code></pre>")
    
    return(cmd)
}
