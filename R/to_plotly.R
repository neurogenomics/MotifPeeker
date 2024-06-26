#' Convert ggplot2 objects to plotly
#' 
#' @param p ggplot2 object
#' @param html_tags Logical. If TRUE, returns the plot as a \code{tagList}
#' object.
#' @param tooltip Character. The tooltip to display. Default is "text".
#' @inheritDotParams plotly::ggplotly
#' 
#' @importFrom plotly ggplotly
#' @importFrom htmltools tagList
#' 
#' @return A \code{plotly} object.
#' 
#' @examples
#' x <- data.frame(a = c(1,2,3), b = c(2,3,4))
#' p <- ggplot2::ggplot(x, ggplot2::aes(x = a, y = b)) + ggplot2::geom_point()
#' to_plotly(p, html_tags = FALSE)
#' 
#' @export
to_plotly <- function(p, html_tags = TRUE, tooltip = "text", ...) {
    pltly <- plotly::ggplotly(p, tooltip = tooltip, ...)
    
    if (html_tags) pltly <- htmltools::tagList(pltly)
    
    return(pltly)
}
