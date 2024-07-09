#' Minimally save a peak object to a file (BED4)
#' 
#' This function saves a peak object to a file in BED4 format. The included
#' columns are: \code{chr}, \code{start}, \code{end}, and \code{name}. Since
#' no strand data is being included, it is recommended to use this function
#' only for peak objects that do not have strand information.
#' 
#' @param peak_obj A GRanges object with the peak coordinates. Must include
#' columns: \code{seqnames}, \code{start}, \code{end}, and \code{name}.
#' @param save A logical indicating whether to save the peak object to a file.
#' @param filename A character string of the file name. If the file extension
#' is not \code{.bed}, a warning is issued and the extension is appended.
#' Alternatively, if the file name does not have an extension, \code{.bed} is
#' appended. (default = random string)
#' @param out_dir A character string of the output directory. (default =
#' tempdir())
#' 
#' @import dplyr
#' @importFrom tools file_ext
#' @importFrom utils write.table
#' 
#' @returns If \code{save = FALSE}, a data frame with the peak coordinates. If
#' \code{save = TRUE}, the path to the saved file.
#' 
#' @examples
#' data("CTCF_ChIP_peaks", package = "MotifPeeker")
#' 
#' out <- save_peak_file(CTCF_ChIP_peaks, save = TRUE, "test_peak_file.bed")
#' print(out)
#' 
#' @export
save_peak_file <- function(peak_obj,
                            save = TRUE,
                            filename = random_string(10),
                            out_dir = tempdir()) {
    ## Parse File Name
    if (tools::file_ext(filename) == "") {
        filename <- paste0(filename, ".bed")
    } else if (tolower(tools::file_ext(filename)) != "bed") {
        wrn_msg <- paste("Filename extension is not", shQuote(".bed"),
                        "Forcing extension.")
        warning(wrn_msg)
    }
    path <- file.path(out_dir, filename)
    
    ## Verify peak_obj columns
    x <- data.frame(peak_obj)
    if (!all(c("seqnames", "start", "end", "name") %in% colnames(x))) {
        stopper("peak_obj must have columns: seqnames, start, end, name.")
    }
    
    names(x)[names(x) == "seqnames"] <- "chr"
    x <- x %>%
        select("chr", "start", "end", "name") %>%
        mutate(start = .data$start - 1)
    
    if (!save) return(x)
        
    write.table(x, path, sep = "\t", row.names = FALSE,
                col.names = FALSE, quote = FALSE)
    return(path)
}
