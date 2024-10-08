% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_enrichment_individual.R
\name{plot_enrichment_individual}
\alias{plot_enrichment_individual}
\title{Plot motif-enrichment for individual experiments}
\usage{
plot_enrichment_individual(
  result,
  enrichment_df,
  comparison_i,
  motif_i,
  label_colours,
  reference_index = 1,
  html_tags = TRUE
)
}
\arguments{
\item{result}{A \code{list} with the following elements:
\describe{
    \item{peaks}{A \code{list} of peak files generated using
\code{\link{read_peak_file}}.}
    \item{alignments}{A \code{list} of alignment files.}
    \item{exp_type}{A \code{character} vector of experiment types.}
    \item{exp_labels}{A \code{character} vector of experiment labels.}
    \item{read_count}{A \code{numeric} vector of read counts.}
    \item{peak_count}{A \code{numeric} vector of peak counts.}
}}

\item{enrichment_df}{A data frame containing the motif enrichment results,
produced using \code{\link{get_df_enrichment}}.}

\item{comparison_i}{The index of the comparison dataset to plot.}

\item{motif_i}{The index of the motif to plot.}

\item{label_colours}{A vector with colours (valid names or hex codes) to use
for "No" and "Yes" bar segments.}

\item{reference_index}{An integer specifying the index of the peak file to
use as the reference dataset for comparison. Indexing starts from 1.
(default = 1)}

\item{html_tags}{Logical. If TRUE, returns the plot as a \code{tagList}
object.}
}
\value{
A \code{plotly} object with the peak motif enrichment data. If
\code{html_tags} is \code{TRUE}, the function returns a \code{tagList} object
instead.
}
\description{
Visualises the result from \code{\link{get_df_enrichment}} for a single motif
by producing a \code{plotly} bar plot with the motif enrichment comparisons
for one comparison dataset pair.
}
\examples{
data("CTCF_ChIP_peaks", package = "MotifPeeker")
data("CTCF_TIP_peaks", package = "MotifPeeker")
data("motif_MA1102.3", package = "MotifPeeker")
data("motif_MA1930.2", package = "MotifPeeker")
input <- list(
    peaks = list(CTCF_ChIP_peaks, CTCF_TIP_peaks),
    exp_type = c("ChIP", "TIP"),
    exp_labels = c("CTCF_ChIP", "CTCF_TIP"),
    read_count = c(150, 200),
    peak_count = c(100, 120)
)
segregated_input <- segregate_seqs(input$peaks[[1]], input$peaks[[2]])
motifs <- list(
    motifs = list(motif_MA1930.2, motif_MA1102.3),
    motif_labels = list("MA1930.2", "MA1102.3")
)
    
\donttest{
    if (requireNamespace("BSgenome.Hsapiens.UCSC.hg38")) {
        genome_build <-
            BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
        enrichment_df <- get_df_enrichment(
            input, segregated_input, motifs, genome_build, reference_index = 1,
            workers = 1
        )
        label_colours <- c("red", "cyan")
    
        plt <- plot_enrichment_individual(
            input, enrichment_df, comparison_i = 2, motif_i = 1,
            label_colours = label_colours, reference_index = 1, html_tags = FALSE
        )
        print(plt)
    }
}

}
\seealso{
Other plot functions: 
\code{\link{plot_enrichment_overall}()},
\code{\link{plot_motif_comparison}()}
}
\concept{plot functions}
