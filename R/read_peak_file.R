#' Read MACS2/3 narrowPeak or SEACR BED peak file
#' 
#' This function reads a MACS2/3 narrowPeak or SEACR BED peak file and
#' returns a GRanges object with the peak coordinates and summit.
#' 
#' The \emph{summit} column is the absolute genomic position of the peak,
#' which is relative to the start position of the sequence range.
#' For SEACR BED files, the \emph{summit} column is calculated as the
#' midpoint of the max signal region.
#' 
#' @param peak_file A character string with the path to the peak file, or a
#' GRanges object created using \code{\link[=read_peak_file]{read_peak_file()}}.
#' @param file_format A character string specifying the format of the peak file.
#' \itemize{
#'  \item \code{"narrowpeak"}: MACS2/3 narrowPeak format.
#'  \item \code{"bed"}: SEACR BED format.
#'  }
#' @param verbose A logical indicating whether to print messages.
#' 
#' @returns A \link[GenomicRanges]{GRanges-class} object with the peak
#' coordinates and summit.
#' 
#' @examples
#' macs3_peak_file <- system.file("extdata", "CTCF_ChIP_peaks.narrowPeak",
#' package = "MotifPeeker")
#' macs3_peak_read <- read_peak_file(macs3_peak_file)
#' macs3_peak_read
#' 
#' @seealso \link[GenomicRanges]{GRanges-class} for more information on GRanges
#' objects.
#' 
#' @export
read_peak_file <- function(peak_file, file_format = "auto", verbose = FALSE) {
    ### Check if peak_file is a GRanges object ###
    if (inherits(peak_file, "GRanges")) {
        ## Verify that the GRanges object has the summit column
        if ("summit" %in% colnames(GenomicRanges::mcols(peak_file))) {
            return(peak_file)
        }
        stp_msg <- paste("GRanges object must have a 'summit' column.",
                        "Use read_peak_file() with peak file path instead.")
    }
    
    ### Infer file_format from extension ###
    file_format <- tolower(file_format)
    if (file_format == "auto") {
        file_ext <- tolower(tools::file_ext(peak_file))
        if (file_ext %in% c("narrowpeak", "bed")) {
            file_format <- file_ext
        } else {
            stp_msg <- paste(
                "Unable to auto-infer peak file format",
                shQuote(file_ext),
                ". Please provide a valid file format",
                "(MACS2/3 narrowPeak, or SEACR BED)."
            )
            stop(stp_msg)
        }
        messager(
            "Auto-inferred peak file format as",
            shQuote(file_format),
            v = verbose
        )
    }
    
    ### Read peak file - MACS2/3 narrowPeak ###
    if (file_format == "narrowpeak") {
        gr_obj <- read_peak_file_macs(peak_file)
    }
    
    ### Read peak file - SEACR BED ###
    if (file_format == "bed") {
        gr_obj <- read_peak_file_seacr(peak_file)
    }
    
    return(gr_obj)
}
