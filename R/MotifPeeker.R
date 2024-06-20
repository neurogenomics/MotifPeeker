#' Benchmark epigenomic profiling methods using motif enrichment
#' 
#' This function compares different epigenomic datasets using motif enrichment
#' as the key metric. The output is an easy-to-interpret HTML document with the
#' results. The report contains three main sections: (1) General Metrics on peak
#' and alignment files (if provided), (2) Known Motif Enrichment Analysis and
#' (3) De-novo Motif Enrichment Analysis.
#' 
#' The function can optionally call peaks using MACS3, but it is recommended
#' that the peak files be supplied directly and produced using fine-tuned
#' parameters.
#' 
#' @param labels A character vector of labels for each peak file.
#' 
#' @param peakfiles A character vector of peak file names in narrowPeak
#' 
#' (MACS2/3 output) or BED (SEACR) format. 
#' @inheritParams check_genome_build
#' 
#' 
#' @export
MotifPeeker <- function(
        peak_files = NULL,
        alignment_files = NULL,
        control_files = NULL,
        labels = NULL,
        exp_type = NULL,
        genome_build,
        motif_files = NULL,
        motif_labels = NULL,
        reference_index = 1,
        cell_counts = NULL,
        peakcalling_qvalue = 0.01,
        denovo_motif_discovery = TRUE,
        denovo_motifs = 3,
        download_buttons = TRUE,
        input_dir = ".",
        output_dir = tempdir(),
        overwrite = FALSE,
        use_cache = TRUE,
        ncpus = 1,
        quiet = FALSE,
        debug = FALSE,
        verbose = FALSE
) {
    ### Time it ###
    start_time <- Sys.time()
    
    ### Force required arguments ###
    force(genome_build)
    
    ## Check if either peak_files or alignment_files are provided
    if (is.null(peak_files) && is.null(alignment_files)) {
        stopper("Please provide either peak_files or alignment_files")
    }
    
    ### Check/get appropriate genome build ###
    genome_build <- check_genome_build(genome_build)
    
    
    return(NULL) # Placeholder
    
}
