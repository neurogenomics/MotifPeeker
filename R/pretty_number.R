#' Convert integers to more readable strings
#' 
#' Format raw numbers to more readable strings. For example, 1000 will be
#' converted to "1K". Supported suffixes are "K", "M", and "B".
#' 
#' @param x A number.
#' @param decimal_digits Number of decimal digits to round to.
#' 
#' @return A character string of the formatted number.
#' 
#' @examples
#' print(pretty_number(134999))
#' 
#' @export
pretty_number <- function(x, decimal_digits = 2) {
    if (is.na(x)) return(x)
    if (x < 1e3) {
        return(as.character(round(x, decimal_digits)))
    } else if (x < 1e6) {
        return(paste0(round(x / 1e3, decimal_digits), "K"))
    } else if (x < 1e9) {
        return(paste0(round(x / 1e6, decimal_digits), "M"))
    } else {
        return(paste0(round(x / 1e9, decimal_digits), "B"))
    }
}
