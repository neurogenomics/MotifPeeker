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
#' ENCODE file IDs can also be provided to automatically fetch peak file(s) from
#' the ENCODE database.
#' @param reference_index An integer specifying the index of the peak file to
#' use as the reference dataset for comparison. Indexing starts from 1.
#' (default = 1)
#' @param alignment_files A character vector of path to alignment files, or a
#' vector of \code{\link[Rsamtools]{BamFile}} objects. (optional)
#' Alignment files are used to calculate read-related metrics like FRiP score.
#' ENCODE file IDs can also be provided to automatically fetch alignment file(s)
#' from the ENCODE database.
#' @param exp_labels A character vector of labels for each peak file. (optional)
#' If not provided, capital letters will be used as labels in the report.
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
#' Required to run \emph{Known Motif Enrichment Analysis}. JASPAR matrix IDs
#' can also be provided to automatically fetch motifs from the JASPAR.
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
#' @param trim_seq_width An integer specifying the width of the sequence to
#' extract around the summit (default = NULL). This sequence is used to search
#' for de novo motifs. If not provided, the entire peak region will be used.
#' This parameter is intended to reduce the search space and speed up motif
#' discovery; therefore, a value less than the average peak width is
#' recommended. Peaks are trimmed symmetrically around the summit while
#' respecting the peak bounds.
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
#' @param quiet A logical indicating whether to print markdown knit messages.
#' (default = FALSE)
#' @param debug A logical indicating whether to print debug/error messages in
#' the HTML report. (default = FALSE)
#' @param verbose A logical indicating whether to print verbose messages while
#' running the function. (default = FALSE)
#' @inheritParams check_genome_build
#' @inheritParams read_motif_file
#' @inheritParams check_genome_build
#' @inheritParams memes::runFimo
#' 
#' @import ggplot2
#' @import tidyverse
#' @importFrom viridis scale_fill_viridis
#' @importFrom tools file_path_sans_ext
#' @importFrom rmarkdown render
#' @importFrom utils browseURL
#' @rawNamespace import(plotly, except = last_plot)
#' 
#' @return Path to the output directory.
#' 
#' @note Running de-novo motif discovery is computationally expensive and can
#' require from minutes to hours. \code{denovo_motifs} can widely affect the
#' runtime (higher values take longer). Setting \code{trim_seq_width} to a lower
#' value can also reduce the runtime significantly.
#' 
#' @examples
#' peaks <- list(
#' system.file("extdata", "CTCF_ChIP_peaks.narrowPeak",
#'            package = "MotifPeeker"),
#' system.file("extdata", "CTCF_TIP_peaks.narrowPeak",
#'             package = "MotifPeeker")
#' )
#' 
#' alignments <- list(
#' system.file("extdata", "CTCF_ChIP_alignment.bam",
#'             package = "MotifPeeker"),
#' system.file("extdata", "CTCF_TIP_alignment.bam",
#'             package = "MotifPeeker")
#' )
#' 
#' motifs <- list(
#' system.file("extdata", "motif_MA1930.2.jaspar",
#'             package = "MotifPeeker"),
#' system.file("extdata", "motif_MA1102.3.jaspar",
#'             package = "MotifPeeker")
#' )
#' 
#' MotifPeeker(
#'     peak_files = peaks,
#'     reference_index = 1,
#'     alignment_files = alignments,
#'     exp_labels = c("ChIP", "TIP"),
#'     exp_type = c("chipseq", "tipseq"),
#'     genome_build = "hg38",
#'     motif_files = motifs,
#'     motif_labels = NULL,
#'     cell_counts = NULL,
#'     denovo_motif_discovery = TRUE,
#'     denovo_motifs = 3,
#'     motif_db = NULL,
#'     download_buttons = TRUE,
#'     output_dir = tempdir(),
#'     use_cache = TRUE,
#'     ncpus = 2,
#'     debug = FALSE,
#'     quiet = TRUE,
#'     verbose = FALSE
#' )
#' 
#' @export
MotifPeeker <- function(
        peak_files,
        reference_index = 1,
        alignment_files = NULL,
        exp_labels = NULL,
        exp_type = NULL,
        genome_build,
        motif_files = NULL,
        motif_labels = NULL,
        cell_counts = NULL,
        denovo_motif_discovery = TRUE,
        denovo_motifs = 3,
        motif_db = NULL,
        trim_seq_width = NULL,
        download_buttons = TRUE,
        meme_path = NULL,
        output_dir = tempdir(),
        display = NULL,
        use_cache = TRUE,
        ncpus = 1,
        quiet = TRUE,
        debug = FALSE,
        verbose = FALSE
) {
    ### Time it ###
    start_time <- Sys.time()

    ### Force required arguments ###
    confirm_meme_install(meme_path = meme_path)
    force(peak_files)
    force(genome_build)
    
    ### Check argument lengths ###
    if (!is.null(alignment_files) &&
        length(peak_files) != length(alignment_files)) {
        stp_msg <- "Length of 'peak_files' and 'alignment_files' must be equal."
        stopper(stp_msg)
    }
    if (!is.null(cell_counts) && length(cell_counts) != length(peak_files)) {
        stp_msg <- "Length of 'cell_counts' must be equal to 'peak_files'."
        stopper(stp_msg)
    }
    
    ### Set labels ###
    if (length(exp_labels) == 0) {
        exp_labels <- LETTERS[seq_along(peak_files)]
    }
    
    ### Create output folder ###
    if (!dir.exists(output_dir)) {
        stp_msg <- "Output directory does not exist."
        stopper(stp_msg)
    }
    output_dir <- file.path(
        output_dir,
        paste0("MotifPeeker_", format(Sys.time(), "%Y%m%d_%H%M%S"))
        )
    dir.create(output_dir, showWarnings = debug)
    
    ### Store arguments in a list ###
    args_list <- list(
        peak_files = peak_files,
        reference_index = reference_index,
        alignment_files = alignment_files,
        exp_labels = exp_labels,
        exp_type = exp_type,
        genome_build = genome_build,
        motif_files = motif_files,
        motif_labels = motif_labels,
        cell_counts = cell_counts,
        denovo_motif_discovery = denovo_motif_discovery,
        denovo_motifs = denovo_motifs,
        motif_db = motif_db,
        trim_seq_width = trim_seq_width,
        download_buttons = download_buttons,
        meme_path = meme_path,
        output_dir = output_dir,
        use_cache = use_cache,
        ncpus = ncpus,
        debug = debug,
        verbose = verbose
    )
    
    ### Knit Rmd ###
    rmd_file <- system.file("markdown",
                            "MotifPeeker.Rmd", package = "MotifPeeker")
    rmarkdown::render(
        input = rmd_file,
        output_dir = output_dir,
        output_file = "MotifPeeker.html",
        quiet = quiet,
        params = args_list
    )
    
    ### Display report ###
    messager(
        "Script run successfully. \nOutput saved at:",
        output_dir,
        "\nTime taken:",
        round(difftime(Sys.time(), start_time, units = "mins"), 2), "mins.",
        v = verbose
    )
    
    if (!is.null(display)) {
        display <- tolower(display)
        if (display == "browser") {
            utils::browseURL(file.path(output_dir, "MotifPeeker.html"))
        } else if (display == "rstudio") {
            file.show(file.path(output_dir, "MotifPeeker.html"))
        }
    }
    
    return(output_dir)
}
