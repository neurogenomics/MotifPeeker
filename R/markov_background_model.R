#' Generate a 0-order Markov background model
#'
#' \code{markov_background_model()} generates a 0-order background model for use
#' with FIMO or AME. The function uses the letter frequencies in the input
#' sequences to generate the background model.
#'
#' @importFrom Biostrings DNAString letterFrequency
#'
#' @param sequences A DNAStringSet object.
#' @param out_dir Location to save the 0-order background file.
#' @param verbose A logical indicating whether to print verbose messages while
#' running the function. (default = FALSE)
#'
#' @returns The path to the 0-order background file.
#'
#' @keywords internal
markov_background_model <- function(sequences, out_dir, verbose = FALSE){
    messager("Generating a 0-order background model", v = verbose)
    seq_string <- paste0(as.character(sequences), collapse = "")
    concat_seq <- Biostrings::DNAString(seq_string)
    frequencies <- Biostrings::letterFrequency(concat_seq,
                                                letters = c("A", "C", "G", "T"),
                                                as.prob = TRUE)
    output_file_path <- file.path(
        out_dir,
        paste0("background_model_", random_string(7), ".txt")
        )
    file_conn <- file(output_file_path, open = "w")
    writeLines("#   order 0", con = file_conn)
    writeLines(sprintf("%s\t%.8f", names(frequencies), frequencies),
                con = file_conn)
    close(file_conn)
    messager("Background model saved to", output_file_path, v = verbose)
    
    return(output_file_path)
}
