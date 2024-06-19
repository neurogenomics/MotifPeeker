#' Report header
#' 
#' Credit: This function was adapted from the \emph{EpiCompare} package.
#' 
#' Generate a header for \link[MotifPeeker]{MotifPeeker} reports generated using 
#' the \emph{MotifPeeker.Rmd} template.
#' @returns Header string to be rendering within Rmarkdown file.
#' 
#' @export
#' @examples 
#' report_header()
report_header <- function() {
    paste0(
        "<div class='report-header'>",
        "<a href=",
        shQuote("https://github.com/neurogenomics/MotifPeeker", type = "sh"),
        " target='_blank'>",
        "<code>MotifPeeker</code>",
        "</a>",
        "<code>Report</code>",
        "<a href=",
        shQuote("https://github.com/neurogenomics/MotifPeeker", type = "sh"),
        " target='_blank'>",
        "<img src=",
        shQuote(
            system.file('hex', 'hex.png', package = 'MotifPeeker'), type = "sh"
            ),
        " height='100'",">",
        "</a>",
        "</div>"
    ) 
}
