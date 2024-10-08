#' Benchmark epigenomic profiling methods using motif enrichment
#' 
#' This function compares different epigenomic datasets using motif enrichment
#' as the key metric. The output is an easy-to-interpret HTML document with the
#' results. The report contains three main sections: (1) General Metrics on peak
#' and alignment files (if provided), (2) Known Motif Enrichment Analysis and
#' (3) De-novo Motif Enrichment Analysis.
#' 
#' Runtime guidance: For 4 datasets, the runtime is approximately 3 minutes with
#' denovo_motif_discovery disabled. However, de-novo motif discovery can take
#' hours to complete. To make computation faster, we highly recommend tuning the
#' following arguments:
#' \describe{
#'     \item{\code{workers}}{Running motif discovery in parallel can
#'     significantly reduce runtime, but it is very memory-intensive, consuming
#'     upwards of 10GB of RAM per thread. Memory starvation can greatly slow the
#'     process, so set \code{workers} with caution.}
#'     \item{\code{denovo_motifs}}{The number of motifs to discover per sequence
#'     group exponentially increases runtime. We recommend no more than 5
#'     motifs to make a meaningful inference.}
#'     \item{\code{trim_seq_width}}{Trimming sequences before running de-novo
#'     motif discovery can significantly reduce the search space. Sequence
#'     length can exponentially increase runtime. We recommend running the
#'     script with \code{denovo_motif_discovery = FALSE} and studying the
#'     motif-summit distance distribution under general metrics to find the
#'     sequence length that captures most motifs. A good starting point is 150
#'     but it can be reduced further if appropriate.}
#' }
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
#' @param download_buttons A logical indicating whether to include download
#' buttons for various files within the HTML report. (default = TRUE)
#' @param out_dir A character string specifying the directory to save the
#' output files. (default = \code{tempdir()}) A sub-directory with the output
#' files will be created in this directory.
#' @param save_runfiles A logical indicating whether to save intermediate files
#' generated during the run, such as those from FIMO and AME. (default = FALSE)
#' @param display A character vector specifying the display mode for the HTML
#' report once it is generated. (default = NULL) Options are:
#' \itemize{
#'     \item \code{"browser"}: Open the report in the default web browser.
#'     \item \code{"rstudio"}: Open the report in the RStudio Viewer.
#'     \item \code{NULL}: Do not open the report.
#' }
#' @param workers An integer specifying the number of threads to use for
#' parallel processing. (default = 1)\cr
#' \strong{IMPORTANT:} For each worker, please ensure a minimum of 6GB of
#' memory (RAM) is available as \code{denovo_motif_discovery} is
#' memory-intensive.
#' @param quiet A logical indicating whether to print markdown knit messages.
#' (default = FALSE)
#' @param debug A logical indicating whether to print debug/error messages in
#' the HTML report. (default = FALSE)
#' @param verbose A logical indicating whether to print verbose messages while
#' running the function. (default = FALSE)
#' @inheritParams check_genome_build
#' @inheritParams read_motif_file
#' @inheritParams check_genome_build
#' @inheritParams get_bpparam
#' @inheritParams memes::runFimo
#' @inheritParams denovo_motifs
#' @inheritParams find_motifs
#' 
#' @import ggplot2
#' @import dplyr
#' @import tidyr
#' @importFrom stats quantile sd
#' @importFrom viridis scale_fill_viridis scale_color_viridis
#' @importFrom tools file_path_sans_ext
#' @importFrom rmarkdown render
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
#'     system.file("extdata", "CTCF_ChIP_peaks.narrowPeak",
#'                 package = "MotifPeeker"),
#'     system.file("extdata", "CTCF_TIP_peaks.narrowPeak",
#'                 package = "MotifPeeker")
#' )
#' 
#' alignments <- list(
#'     system.file("extdata", "CTCF_ChIP_alignment.bam",
#'                 package = "MotifPeeker"),
#'     system.file("extdata", "CTCF_TIP_alignment.bam",
#'                 package = "MotifPeeker")
#' )
#' 
#' motifs <- list(
#'     system.file("extdata", "motif_MA1930.2.jaspar",
#'                 package = "MotifPeeker"),
#'     system.file("extdata", "motif_MA1102.3.jaspar",
#'                 package = "MotifPeeker")
#' )
#' 
#' \donttest{
#'     # MotifPeeker takes time to run
#'     MotifPeeker(
#'         peak_files = peaks,
#'         reference_index = 1,
#'         alignment_files = alignments,
#'         exp_labels = c("ChIP", "TIP"),
#'         exp_type = c("chipseq", "tipseq"),
#'         genome_build = "hg38",
#'         motif_files = motifs,
#'         motif_labels = NULL,
#'         cell_counts = NULL,
#'         denovo_motif_discovery = TRUE,
#'         denovo_motifs = 1,
#'         motif_db = NULL,
#'         download_buttons = TRUE,
#'         out_dir = tempdir(),
#'         workers = 1,
#'         debug = FALSE,
#'         quiet = TRUE,
#'         verbose = FALSE
#'     )
#' }
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
        filter_n = 6,
        trim_seq_width = NULL,
        motif_db = NULL,
        download_buttons = TRUE,
        meme_path = NULL,
        out_dir = tempdir(),
        save_runfiles = FALSE,
        display = if (interactive()) "browser",
        workers = 2,
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
    if (!is.null(alignment_files)) {
        stp_msg <- paste("Length of", shQuote("peak_files"), "and",
        shQuote("alignment_files"), "must be equal.")
        len_peak_files <- if (is.list(peak_files)) length(peak_files) else 1
        len_alignment_files <- if (is.list(alignment_files))
            length(alignment_files) else 1
        if (len_peak_files != len_alignment_files) {
            stopper(stp_msg)
        }
    }
    if (!is.null(cell_counts) && length(cell_counts) != length(peak_files)) {
        stp_msg <- paste0("Length of ", shQuote("cell_counts"), " must be ",
        "equal to ", shQuote("peak_files"), ".")
        stopper(stp_msg)
    }
    if (denovo_motif_discovery &&
        (is.null(denovo_motifs) || denovo_motifs < 1)) {
        stp_msg <- "Number of de-novo motifs to find must be greater than 0."
        stopper(stp_msg)
    }
    
    ### Check duplicate labels ###
    check_duplicates(exp_labels)
    check_duplicates(motif_labels)
    
    ### Set labels ###
    if (length(exp_labels) == 0) {
        exp_labels <- LETTERS[seq_along(peak_files)]
    }
    
    ### Create output folder ###
    if (!dir.exists(out_dir)) {
        stp_msg <- "Output directory does not exist."
        stopper(stp_msg)
    }
    out_dir <- file.path(
        out_dir,
        paste0("MotifPeeker_", format(Sys.time(), "%Y%m%d_%H%M%S"))
        )
    dir.create(out_dir, showWarnings = debug)
    
    ### Normalise input paths ###
    out_dir <- normalizePath(out_dir)
    peak_files <- normalise_paths(peak_files)
    alignment_files <- normalise_paths(alignment_files)
    motif_files <- normalise_paths(motif_files)
    
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
        filter_n = filter_n,
        motif_db = motif_db,
        trim_seq_width = trim_seq_width,
        download_buttons = download_buttons,
        meme_path = meme_path,
        out_dir = out_dir,
        save_runfiles = save_runfiles,
        workers = workers,
        debug = debug,
        verbose = verbose
    )
    
    ### Knit Rmd ###
    rmd_file <- system.file("markdown",
                            "MotifPeeker.Rmd", package = "MotifPeeker")
    rmarkdown::render(
        input = rmd_file,
        output_dir = out_dir,
        output_file = "MotifPeeker.html",
        quiet = quiet,
        params = args_list
    )
    
    ### Display report ###
    messager(
        "Script run successfully. \nOutput saved at:",
        out_dir,
        "\nTime taken:",
        round(difftime(Sys.time(), start_time, units = "mins"), 2), "mins.",
        v = verbose
    )
    
    if (!is.null(display)) {
        display <- tolower(display)
        if (display == "browser") {
            check_dep("utils")
            utils::browseURL(file.path(out_dir, "MotifPeeker.html"))
        } else if (display == "rstudio") {
            file.show(file.path(out_dir, "MotifPeeker.html"))
        }
    }
    
    return(out_dir)
}
