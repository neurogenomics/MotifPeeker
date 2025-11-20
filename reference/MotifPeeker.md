# Benchmark epigenomic profiling methods using motif enrichment

This function compares different epigenomic datasets using motif
enrichment as the key metric. The output is an easy-to-interpret HTML
document with the results. The report contains three main sections: (1)
General Metrics on peak and alignment files (if provided), (2) Known
Motif Enrichment Analysis and (3) Discovered Motif Enrichment Analysis.

## Usage

``` r
MotifPeeker(
  peak_files,
  reference_index = 1,
  alignment_files = NULL,
  exp_labels = NULL,
  exp_type = NULL,
  genome_build,
  motif_files = NULL,
  motif_labels = NULL,
  cell_counts = NULL,
  distance_bootstrap = TRUE,
  bootstrap_n = 500,
  bootstrap_len = NULL,
  motif_discovery = TRUE,
  motif_discovery_count = 3,
  filter_n = 6,
  trim_seq_width = NULL,
  motif_db = NULL,
  download_buttons = TRUE,
  meme_path = NULL,
  out_dir = tempdir(),
  save_runfiles = FALSE,
  display = if (interactive()) "browser",
  BPPARAM = BiocParallel::SerialParam(),
  quiet = TRUE,
  debug = FALSE,
  verbose = FALSE
)
```

## Arguments

- peak_files:

  A character vector of path to peak files, or a vector of GRanges
  objects generated using
  [`read_peak_file`](https://neurogenomics.github.io/MotifPeeker/reference/read_peak_file.md).
  Currently, peak files from the following peak-calling tools are
  supported:

  - MACS2: `.narrowPeak` files

  - SEACR: `.bed` files

  ENCODE file IDs can also be provided to automatically fetch peak
  file(s) from the ENCODE database.

- reference_index:

  An integer specifying the index of the peak file to use as the
  reference dataset for comparison. Indexing starts from 1. (default =
  1)

- alignment_files:

  A character vector of path to alignment files, or a vector of
  [`BamFile`](https://rdrr.io/pkg/Rsamtools/man/BamFile-class.html)
  objects. (optional) Alignment files are used to calculate read-related
  metrics like FRiP score. ENCODE file IDs can also be provided to
  automatically fetch alignment file(s) from the ENCODE database.

- exp_labels:

  A character vector of labels for each peak file. (optional) If not
  provided, capital letters will be used as labels in the report.

- exp_type:

  A character vector of experimental types for each peak file.
  (optional) Useful for comparison of different methods. If not
  provided, all datasets will be classified as "unknown" experiment
  types in the report. Supported experimental types are:

  - `chipseq`: ChIP-seq data

  - `tipseq`: TIP-seq data

  - `cuttag`: CUT&Tag data

  - `cutrun`: CUT&Run data

  `exp_type` is used only for labelling. It does not affect the
  analysis. You can also input custom strings. Datasets will be grouped
  as long as they match their respective `exp_type`.

- genome_build:

  A character string with the abbreviated genome build name, or a
  BSGenome object. Check
  [check_genome_build](https://neurogenomics.github.io/MotifPeeker/reference/check_genome_build.md)
  details for genome builds which can be imported as abbreviated names.

- motif_files:

  A character vector of path to motif files, or a vector of
  [`universalmotif-class`](https://rdrr.io/pkg/universalmotif/man/universalmotif-class.html)
  objects. (optional) Required to run *Known Motif Enrichment Analysis*.
  JASPAR matrix IDs can also be provided to automatically fetch motifs
  from the JASPAR.

- motif_labels:

  A character vector of labels for each motif file. (optional) Only used
  if path to file names are passed in `motif_files`. If not provided,
  the motif file names will be used as labels.

- cell_counts:

  An integer vector of experiment cell counts for each peak file.
  (optional) Creates additional comparisons based on cell counts.

- distance_bootstrap:

  A logical indicating whether to perform bootstrap analysis for
  motif-peak summit distances. (default = TRUE) If `FALSE`, a single
  distribution of distances will be calculated for each experiment-motif
  pair without bootstrapping.

- bootstrap_n:

  An integer specifying the number of bootstrap samples to generate.
  (default = 500) If `NULL`, a value of
  `0.7 x number of peaks in the smallest peakset` will be used (or if
  this value is less than 100, use 100).

- bootstrap_len:

  An integer specifying the length of sequences to sample in each
  bootstrap iteration. (default = NULL) If `NULL`, a value of
  `0.2 x number of peaks in the smallest peakset` will be used (or if
  this value is less than 10, use 10).

- motif_discovery:

  A logical indicating whether to perform motif discovery for the third
  section of the report. (default = TRUE)

- motif_discovery_count:

  An integer specifying the number of motifs to discover. (default = 3)
  Note that higher values take longer to compute.

- filter_n:

  An integer specifying the number of consecutive nucleotide repeats a
  discovered motif must contain to be filtered out. (default = 6)

- trim_seq_width:

  An integer specifying the width of the sequence to extract around the
  summit (default = NULL). This sequence is used to search for
  discovered motifs. If not provided, the entire peak region will be
  used. This parameter is intended to reduce the search space and speed
  up motif discovery; therefore, a value less than the average peak
  width is recommended. Peaks are trimmed symmetrically around the
  summit while respecting the peak bounds.

- motif_db:

  Path to `.meme` format file to use as reference database, or a list of
  [`universalmotif-class`](https://rdrr.io/pkg/universalmotif/man/universalmotif-class.html)
  objects. (optional) Results from de-novo motif discovery are searched
  against this database to find similar motifs. If not provided, JASPAR
  CORE database will be used. **NOTE**: p-value estimates are inaccurate
  when the database has fewer than 50 entries.

- download_buttons:

  A logical indicating whether to include download buttons for various
  files within the HTML report. (default = TRUE)

- meme_path:

  path to `meme/bin/` (optional). Defaut: `NULL`, searches "MEME_PATH"
  environment variable or "meme_path" option for path to "meme/bin/".

- out_dir:

  A character string specifying the directory to save the output files.
  (default = [`tempdir()`](https://rdrr.io/r/base/tempfile.html)) A
  sub-directory with the output files will be created in this directory.

- save_runfiles:

  A logical indicating whether to save intermediate files generated
  during the run, such as those from FIMO and AME. (default = FALSE)

- display:

  A character vector specifying the display mode for the HTML report
  once it is generated. (default = NULL) Options are:

  - `"browser"`: Open the report in the default web browser.

  - `"rstudio"`: Open the report in the RStudio Viewer.

  - `NULL`: Do not open the report.

- BPPARAM:

  A
  [`BiocParallelParam-class`](https://rdrr.io/pkg/BiocParallel/man/BiocParallelParam-class.html)
  object enabling parallel execution. (default = SerialParam(),
  single-CPU run)  
    
  Following are two examples of how to set up parallel processing:

  - `BPPARAM = BiocParallel::MulticoreParam(4)`: Uses 4 CPU cores for
    parallel processing.

  - [`library("BiocParallel")`](https://github.com/Bioconductor/BiocParallel)
    followed by `register(MulticoreParam(4))` sets all subsequent
    BiocParallel functions to use 4 CPU cores. `Motifpeeker()` must be
    run with `BPPARAM = BiocParallel::MulticoreParam()`.

  **IMPORTANT:** For each worker, please ensure a minimum of 8GB of
  memory (RAM) is available as `motif_discovery` is memory-intensive.

- quiet:

  A logical indicating whether to print markdown knit messages. (default
  = FALSE)

- debug:

  A logical indicating whether to print debug/error messages in the HTML
  report. (default = FALSE)

- verbose:

  A logical indicating whether to print verbose messages while running
  the function. (default = FALSE)

## Value

Path to the output directory.

## Details

Runtime guidance: For 4 datasets, the runtime is approximately 3 minutes
with motif_discovery disabled. However, motif discovery can take hours
to complete. To make computation faster, we highly recommend tuning the
following arguments:

- `BPPARAM=MulticoreParam(x)`:

  Running motif discovery in parallel can significantly reduce runtime,
  but it is very memory-intensive, consuming 10+GB of RAM per thread.
  Memory starvation can greatly slow the process, so set the number of
  cores with caution.

- `motif_discovery_count`:

  The number of motifs to discover per sequence group exponentially
  increases runtime. We recommend no more than 5 motifs to make a
  meaningful inference.

- `trim_seq_width`:

  Trimming sequences before running motif discovery can significantly
  reduce the search space. Sequence length can exponentially increase
  runtime. We recommend running the script with
  `motif_discovery = FALSE` and studying the motif-summit distance
  distribution under general metrics to find the sequence length that
  captures most motifs. A good starting point is 150 but it can be
  reduced further if appropriate.

## Note

Running motif discovery is computationally expensive and can require
from minutes to hours. `denovo_motifs` can widely affect the runtime
(higher values take longer). Setting `trim_seq_width` to a lower value
can also reduce the runtime significantly.

## Examples

``` r
peaks <- list(
    system.file("extdata", "CTCF_ChIP_peaks.narrowPeak",
                package = "MotifPeeker"),
    system.file("extdata", "CTCF_TIP_peaks.narrowPeak",
                package = "MotifPeeker")
)

alignments <- list(
    system.file("extdata", "CTCF_ChIP_alignment.bam",
                package = "MotifPeeker"),
    system.file("extdata", "CTCF_TIP_alignment.bam",
                package = "MotifPeeker")
)

motifs <- list(
    system.file("extdata", "motif_MA1930.2.jaspar",
                package = "MotifPeeker"),
    system.file("extdata", "motif_MA1102.3.jaspar",
                package = "MotifPeeker")
)

if (memes::meme_is_installed()) {
    MotifPeeker(
        peak_files = peaks,
        reference_index = 2,
        alignment_files = alignments,
        exp_labels = c("ChIP", "TIP"),
        exp_type = c("chipseq", "tipseq"),
        genome_build = "hg38",
        motif_files = motifs,
        motif_labels = NULL,
        cell_counts = NULL,
        distance_bootstrap = TRUE,
        bootstrap_n = 2,
        bootstrap_len = 40,
        motif_discovery = TRUE,
        motif_discovery_count = 2,
        motif_db = NULL,
        download_buttons = TRUE,
        out_dir = tempdir(),
        debug = FALSE,
        quiet = TRUE,
        verbose = FALSE
    )
}
#> [1] "/tmp/Rtmpwfd8EW/MotifPeeker_20251120_123157"
```
