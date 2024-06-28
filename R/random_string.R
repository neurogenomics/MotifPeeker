#' Generate a random string
#'
#' @param length The length of the random string to generate.
#'
#' @returns A random string of the specified length.
#' 
#' @keywords internal
random_string <- function(length) {
    char_base <- c(0:9, letters)
    random_chars <- sample(char_base, length, replace = TRUE)
    return(paste(random_chars, collapse = ""))
}
