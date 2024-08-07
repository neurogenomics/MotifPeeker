% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/save_peak_file.R
\name{save_peak_file}
\alias{save_peak_file}
\title{Minimally save a peak object to a file (BED4)}
\usage{
save_peak_file(
  peak_obj,
  save = TRUE,
  filename = random_string(10),
  out_dir = tempdir()
)
}
\arguments{
\item{peak_obj}{A GRanges object with the peak coordinates. Must include
columns: \code{seqnames}, \code{start}, \code{end}, and \code{name}.}

\item{save}{A logical indicating whether to save the peak object to a file.}

\item{filename}{A character string of the file name. If the file extension
is not \code{.bed}, a warning is issued and the extension is appended.
Alternatively, if the file name does not have an extension, \code{.bed} is
appended. (default = random string)}

\item{out_dir}{A character string of the output directory. (default =
tempdir())}
}
\value{
If \code{save = FALSE}, a data frame with the peak coordinates. If
\code{save = TRUE}, the path to the saved file.
}
\description{
This function saves a peak object to a file in BED4 format. The included
columns are: \code{chr}, \code{start}, \code{end}, and \code{name}. Since
no strand data is being included, it is recommended to use this function
only for peak objects that do not have strand information.
}
\examples{
data("CTCF_ChIP_peaks", package = "MotifPeeker")

out <- save_peak_file(CTCF_ChIP_peaks, save = TRUE, "test_peak_file.bed")
print(out)

}
