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
#' 
#' @param peak_files A character vector of path to peak files, or a vector of
#' GRanges objects generated using \code{\link{read_peak_file}}. Currently,
#' peak files from the following peak-calling tools are supported:
#' \itemize{
#'    \item MACS2: \code{.narrowPeak} files
#'    \item SEACR: \code{.bed} files
#' }
#' @param reference_index An integer specifying the index of the peak file to
#' use as the reference dataset for comparison. Indexing starts from 1.
#' (default = 1)
#' @param alignment_files A character vector of path to alignment files, or a
#' vector of \code{\link[Rsamtools]{BamFile}} objects. (optional)
#' Alignment files are used to calculate read-related metrics like FRiP score.
#' @param labels A character vector of labels for each peak file. (optional)
#' If not provided, the peak file names will be used as labels.
#' @param exp_type A character vector of experimental types for each peak file.
#' (optional) Useful for comparison of different methods. If not provided,
#' all datasets will be classified as "unknown" experiment types in the report.
#' Supported experimental types are:
#' \itemize{
#'   \item \code{chipseq}: ChIP-seq data
#'   \item \code{tipseq}: TIP-seq data
#'   \item \code{cuttag}: CUT&Tag data
#'   \item \code{cutrun}: CUT&Run data
#' }
#' \code{exp_type} is used only for labelling. It does not affect the analysis.
#' You can also input custom strings. Datasets will be grouped as long as they
#' match their respective \code{exp_type}.
#' @param motif_files A character vector of path to motif files, or a vector of
#' \code{\link[universalmotif]{universalmotif-class}} objects. (optional)
#' Required to run \emph{Known Motif Enrichment Analysis}.
#' @param motif_labels A character vector of labels for each motif file.
#' (optional) Only used if path to file names are passed in
#' \code{motif_files}. If not provided, the motif file names will be used as
#' labels.
#' @param cell_counts An integer vector of experiment cell counts for each peak
#' file. (optional) Creates additional comparisons based on cell counts.
#' @param denovo_motif_discovery A logical indicating whether to perform
#' de-novo motif discovery for the third section of the report. (default = TRUE)
#' @param denovo_motifs An integer specifying the number of de-novo motifs to
#' discover. (default = 3) Note that higher values take longer to compute.
#' @param motif_db Path to \code{.meme} format file to use as reference
#' database, or a list of \code{\link[universalmotif]{universalmotif-class}}
#' objects. (optional) Results from de-novo motif discovery are searched against
#' this database to find similar motifs. If not provided, JASPAR CORE database
#' will be used. \strong{NOTE}: p-value estimates are inaccurate when the
#' database has fewer than 50 entries.
#' @param download_buttons A logical indicating whether to include download
#' buttons for various files within the HTML report. (default = TRUE)
#' @param output_dir A character string specifying the directory to save the
#' output files. (default = \code{tempdir()}) A sub-directory with the output
#' files will be created in this directory.
#' @param display A character vector specifying the display mode for the HTML
#' report once it is generated. (default = NULL) Options are:
#' \itemize{
#'     \item \code{"browser"}: Open the report in the default web browser.
#'     \item \code{"rstudio"}: Open the report in the RStudio Viewer.
#'     \item \code{NULL}: Do not open the report.
#' }
#' @param use_cache A logical indicating whether to use cached results from
#' previous runs. (default = TRUE)
#' @param ncpus An integer specifying the number of cores to use for parallel
#' processing. (default = 1)
#' @param quiet A logical indicating whether to suppress messages in the
#' HTML report.
#' (default = FALSE)
#' @param debug A logical indicating whether to print debug messages in the
#' HTML report. (default = FALSE)
#' @param verbose A logical indicating whether to print verbose messages while
#' running the function. (default = FALSE)
#' @inheritParams check_genome_build
#' @inheritParams read_motif_file
#' @inheritParams check_genome_build
#' 
#' @return Path to the output directory.
#' 
#' @note Running de-novo motif discovery is computationally expensive and can
#' require from minutes to hours. \code{denovo_motifs} can widely affect the
#' runtime (higher values take longer).
#' 
#' @export
MotifPeeker <- function(
        peak_files,
        reference_index = 1,
        alignment_files = NULL,
        labels = NULL,
        exp_type = NULL,
        genome_build,
        motif_files = NULL,
        motif_labels = NULL,
        cell_counts = NULL,
        denovo_motif_discovery = TRUE,
        denovo_motifs = 3,
        motif_db = NULL,
        download_buttons = TRUE,
        output_dir = tempdir(),
        display = NULL,
        use_cache = TRUE,
        ncpus = 1,
        quiet = FALSE,
        debug = FALSE,
        verbose = FALSE
) {
    ### Time it ###
    start_time <- Sys.time()

    ### Force required arguments ###
    force(peak_files)
    force(genome_build)

    ## Check if either peak_files or alignment_files are provided
    if (is.null(peak_files) && is.null(alignment_files)) {
        stopper("Please provide either peak_files or alignment_files")
    }

    ### Check/get appropriate genome build ###
    genome_build <- check_genome_build(genome_build)


    return(NULL) # Placeholder

}
