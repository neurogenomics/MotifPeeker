#' Read MACS2/3 narrowPeak peak file
#'
#' This function reads a MACS2/3 narrowPeak peak file and returns a GRanges
#' object with the peak coordinates and summit.
#'
#' @inherit read_peak_file details params seealso return examples
#'
#' @keywords internal
read_peak_file_macs <- function(peak_file) {
  obj <- rtracklayer::import(peak_file, format = "narrowPeak")

  if (any(is.na(GenomicRanges::mcols(obj)$name))) {
    GenomicRanges::mcols(obj)$name <- mapply(function(i) {
      paste0("Peak_", i)
    }, seq_along(obj))
  }

  names(obj) <- GenomicRanges::mcols(obj)$name

  ## Add metadata summit column
  GenomicRanges::mcols(obj)$summit <-
    GenomicRanges::start(obj) + GenomicRanges::mcols(obj)$peak

  return(obj)
}
