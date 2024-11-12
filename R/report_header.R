#' Report header
#' 
#' Credit: This function was adapted from the \emph{EpiCompare} package.
#' 
#' Generate a header for \link[MotifPeeker]{MotifPeeker} reports generated using 
#' the \emph{MotifPeeker.Rmd} template.
#' 
#' @importFrom utils packageVersion
#' 
#' @returns Header string to be rendering within Rmarkdown file.
#' 
#' @examples 
#' MotifPeeker:::report_header()
#' 
#' @keywords internal
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
        "<br>",
        "<span style=",
        shQuote(paste("font-size: 0.4em; color: #827594; margin-top: -1.6em;",
        "margin-left: 0.4em; margin-bottom: 3em; display: block;")),
        ">version ",
        utils::packageVersion("MotifPeeker"),
        "</span>",
        "</div>"
    ) 
}
