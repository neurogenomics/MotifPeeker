#' Get download buttons for peak file, STREME and TOMOTM output
#' 
#' @param comparison_i Index of the comparison pair group.
#' @param start_i Index of the first comparison pair.
#' @param segregated_peaks A list of peak files generated from
#' \code{\link{segregate_seqs}}.
#' @param out_dir A character vector of the directory with STREME and TOMTOM
#' output.
#' @param add_buttons A logical indicating whether to prepare download buttons.
#' @param verbose A logical indicating whether to print messages.
#' 
#' @returns A list of download buttons for peak file, STREME and TOMTOM output.
#' 
#' @keywords internal
get_download_buttons <- function(comparison_i,
                                start_i,
                                segregated_peaks,
                                out_dir,
                                add_buttons = TRUE,
                                verbose = FALSE) {
    if (!add_buttons) return(NULL)
    messager("Generating download buttons...", v = verbose)
    
    ### Peak file button ###
    btns1 <- lapply(seq_len(4), function(x) {
        peak_file <- save_peak_file(segregated_peaks[[comparison_i]][[x]])
        download_button(
            peak_file,
            type = "file",
            button_label = "Download: <code>Peak file</code>",
            output_name = paste0("peak_", random_string(6))
        )
    })
    
    ### STREME output button ###
    btns2 <- lapply(seq_len(4), function(x) {
        streme_path <- file.path(out_dir, "streme", start_i + x - 1)
        if (!dir.exists(streme_path)) return(NULL)
        download_button(
            streme_path,
            type = "dir",
            button_label = "Download: <code>STREME output</code>",
            output_name = paste0("streme_", random_string(6))
        )
    })
    
    ### TOMTOM output button ###
    btns3 <- lapply(seq_len(4), function(x) {
        tomtom_path <- file.path(out_dir, "tomtom", start_i + x - 1)
        if (!dir.exists(tomtom_path)) return(NULL)
        download_button(
            tomtom_path,
            type = "dir",
            button_label = "Download: <code>TOMTOM output</code>",
            output_name = paste0("tomtom_", random_string(6))
        )
    })
    
    all_btns <- list(
        peak_file = btns1,
        streme_output = btns2,
        tomtom_output = btns3
    )
    return(all_btns)
}
