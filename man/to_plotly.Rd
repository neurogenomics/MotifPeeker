% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/to_plotly.R
\name{to_plotly}
\alias{to_plotly}
\title{Convert ggplot2 objects to plotly}
\usage{
to_plotly(p, html_tags = TRUE, tooltip = "text", ...)
}
\arguments{
\item{p}{ggplot2 object}

\item{html_tags}{Logical. If TRUE, returns the plot as a \code{tagList}
object.}

\item{tooltip}{Character. The tooltip to display. Default is "text".}

\item{...}{
  Arguments passed on to \code{\link[plotly:ggplotly]{plotly::ggplotly}}
  \describe{
    \item{\code{width}}{Width of the plot in pixels (optional, defaults to automatic sizing).}
    \item{\code{height}}{Height of the plot in pixels (optional, defaults to automatic sizing).}
    \item{\code{dynamicTicks}}{should plotly.js dynamically generate axis tick labels?
Dynamic ticks are useful for updating ticks in response to zoom/pan
interactions; however, they can not always reproduce labels as they
would appear in the static ggplot2 image.}
    \item{\code{layerData}}{data from which layer should be returned?}
    \item{\code{originalData}}{should the "original" or "scaled" data be returned?}
    \item{\code{source}}{a character string of length 1. Match the value of this string
with the source argument in \code{\link[plotly:event_data]{event_data()}} to retrieve the
event data corresponding to a specific plot (shiny apps can have multiple plots).}
  }}
}
\value{
A \code{plotly} object.
}
\description{
Convert ggplot2 objects to plotly
}
\examples{
x <- data.frame(a = c(1,2,3), b = c(2,3,4))
p <- ggplot2::ggplot(x, ggplot2::aes(x = a, y = b)) + ggplot2::geom_point()
to_plotly(p, html_tags = FALSE)

}
\seealso{
\link[plotly]{ggplotly}
}
