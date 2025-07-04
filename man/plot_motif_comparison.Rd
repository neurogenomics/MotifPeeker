% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_motif_comparison.R
\name{plot_motif_comparison}
\alias{plot_motif_comparison}
\title{Produce heat maps of motif similarity matrices}
\usage{
plot_motif_comparison(
  comparison_matrices,
  exp_labels,
  height = NULL,
  width = NULL,
  html_tags = TRUE
)
}
\arguments{
\item{comparison_matrices}{Output from
\code{\link[universalmotif]{compare_motifs}} for one comparison pair (Four
matrices).}

\item{exp_labels}{Labels for the reference and comparison experiments
respectively.}

\item{width, height}{The width and height of the output htmlwidget, or the
output file if exporting to png/pdf/etc. Presumed to be in pixels, but
if a plotly internal function decides it's in other units you may end up
with a huge file! Default is 800x500 when exporting to a file, and 100% width
as a htmlwidget.}

\item{html_tags}{Logical. If TRUE, returns the plot as a \code{tagList}
object.}
}
\value{
A list of individual heat maps for the four matrices. If
\code{html_tags} is \code{TRUE}, the output will be wrapped in HTML tags.
}
\description{
Produce heat maps of motif similarity matrices
}
\seealso{
Other plot functions: 
\code{\link{plot_enrichment_individual}()},
\code{\link{plot_enrichment_overall}()}
}
\concept{plot functions}
\keyword{internal}
