% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/denovo_motifs.R
\name{denovo_motifs}
\alias{denovo_motifs}
\title{Discover motifs in sequences}
\usage{
denovo_motifs(
  seqs,
  trim_seq_width,
  genome_build,
  discover_motifs_count = 3,
  minw = 8,
  maxw = 25,
  filter_n = 6,
  out_dir = tempdir(),
  meme_path = NULL,
  BPPARAM = BiocParallel::SerialParam(),
  verbose = FALSE,
  debug = FALSE,
  ...
)
}
\arguments{
\item{seqs}{A list of \code{\link[GenomicRanges]{GRanges}} objects containing
sequences to search for motifs.}

\item{trim_seq_width}{An integer specifying the width of the sequence to
extract around the summit (default = NULL). This sequence is used to search
for discovered motifs. If not provided, the entire peak region will be used.
This parameter is intended to reduce the search space and speed up motif
discovery; therefore, a value less than the average peak width is
recommended. Peaks are trimmed symmetrically around the summit while
respecting the peak bounds.}

\item{genome_build}{The genome build that the peak sequences should be
derived from.}

\item{discover_motifs_count}{An integer specifying the number of motifs to
discover. (default = 3) Note that higher values take longer to compute.}

\item{minw}{An integer specifying the minimum width of the motif.
(default = 8)}

\item{maxw}{An integer specifying the maximum width of the motif.
(default = 25)}

\item{filter_n}{An integer specifying the number of consecutive nucleotide
repeats a discovered motif must contain to be filtered out.
(default = 6)}

\item{out_dir}{A \code{character} vector of output directory to save STREME
results to. (default = \code{tempdir()})}

\item{meme_path}{path to "meme/bin/" (default: \code{NULL}). Will use default
search behavior as described in \code{check_meme_install()} if unset.}

\item{BPPARAM}{A \code{\link[BiocParallel]{BiocParallelParam-class}} object
specifying run parameters. (default = SerialParam(), single core run)}

\item{verbose}{A logical indicating whether to print verbose messages while
running the function. (default = FALSE)}

\item{debug}{A logical indicating whether to print debug messages while
running the function. (default = FALSE)}

\item{...}{Additional arguments to pass to \code{STREME}. For more
information, refer to the official MEME Suite documentation on
\href{https://meme-suite.org/meme/doc/streme.html}{STREME}.}
}
\value{
A list of \code{\link[universalmotif]{universalmotif}} objects and
associated metadata.
}
\description{
Use STREME from MEME suite to find  motifs in the provided sequences.
To speed up the process, the sequences can be optionally trimmed to reduce
the search space. The result is then optionally filtered to remove motifs
with a high number of nucleotide repeats
}
\examples{
if (memes::meme_is_installed()) {
data("CTCF_TIP_peaks", package = "MotifPeeker")
if (requireNamespace("BSgenome.Hsapiens.UCSC.hg38", quietly = TRUE)) {
    genome_build <- BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
   
    res <- denovo_motifs(list(CTCF_TIP_peaks),
                        trim_seq_width = 50,
                        genome_build = genome_build,
                        discover_motifs_count = 1,
                        filter_n = 6,
                        minw = 8,
                        maxw = 8,
                        out_dir = tempdir())
    print(res[[1]]$consensus)
}
}
}
