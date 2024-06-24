#' Read SEACR BED peak file
#' 
#' This function reads a SEACR BED peak file and returns a GRanges object with
#' the peak coordinates and summit.
#' 
#' @inherit read_peak_file details params seealso return
#' 
#' @keywords internal
read_peak_file_seacr <- function(peak_file) {
    # Read BED file as table
    obj <- utils::read.table(peak_file, header = TRUE)
    names(obj) <- c("chr",
                    "start",
                    "end",
                    "total_signal",
                    "max_signal",
                    "max_signal_region")
    
    ## Create summit column
    separated_cols <- strsplit(as.character(obj$max_signal_region),
                                "[:|-]")
    obj$max_chr <- vapply(separated_cols, function(x) x[1], character(1))
    obj$max_start <- vapply(separated_cols, function(x) x[2], character(1))
    obj$max_end <- vapply(separated_cols, function(x) x[3], character(1))
    obj$summit <- floor(
        (as.numeric(obj$max_start) + as.numeric(obj$max_end)) / 2
    )
    
    ## Create GRanges object
    gr_ranges <- IRanges::IRanges(start = obj$start, end = obj$end)
    
    gr_obj <- GenomicRanges::GRanges(
        seqnames = obj$chr,
        ranges = gr_ranges,
        strand = "*"
    )
    
    GenomicRanges::mcols(gr_obj)$summit <- obj$summit
    GenomicRanges::mcols(gr_obj)$name <- paste0("peak_", seq_len(nrow(obj)))
    names(gr_obj) <- GenomicRanges::mcols(gr_obj)$name
    
    return(gr_obj)
}
