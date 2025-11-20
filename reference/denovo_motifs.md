# Discover motifs in sequences

Use STREME from MEME suite to find motifs in the provided sequences. To
speed up the process, the sequences can be optionally trimmed to reduce
the search space. The result is then optionally filtered to remove
motifs with a high number of nucleotide repeats

## Usage

``` r
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
```

## Arguments

- seqs:

  A list of
  [`GRanges`](https://rdrr.io/pkg/GenomicRanges/man/GRanges-class.html)
  objects containing sequences to search for motifs.

- trim_seq_width:

  An integer specifying the width of the sequence to extract around the
  summit (default = NULL). This sequence is used to search for
  discovered motifs. If not provided, the entire peak region will be
  used. This parameter is intended to reduce the search space and speed
  up motif discovery; therefore, a value less than the average peak
  width is recommended. Peaks are trimmed symmetrically around the
  summit while respecting the peak bounds.

- genome_build:

  The genome build that the peak sequences should be derived from.

- discover_motifs_count:

  An integer specifying the number of motifs to discover. (default = 3)
  Note that higher values take longer to compute.

- minw:

  An integer specifying the minimum width of the motif. (default = 8)

- maxw:

  An integer specifying the maximum width of the motif. (default = 25)

- filter_n:

  An integer specifying the number of consecutive nucleotide repeats a
  discovered motif must contain to be filtered out. (default = 6)

- out_dir:

  A `character` vector of output directory to save STREME results to.
  (default = [`tempdir()`](https://rdrr.io/r/base/tempfile.html))

- meme_path:

  path to "meme/bin/" (default: `NULL`). Will use default search
  behavior as described in `check_meme_install()` if unset.

- BPPARAM:

  A
  [`BiocParallelParam-class`](https://rdrr.io/pkg/BiocParallel/man/BiocParallelParam-class.html)
  object specifying run parameters. (default = SerialParam(), single
  core run)

- verbose:

  A logical indicating whether to print verbose messages while running
  the function. (default = FALSE)

- debug:

  A logical indicating whether to print debug messages while running the
  function. (default = FALSE)

- ...:

  Additional arguments to pass to `STREME`. For more information, refer
  to the official MEME Suite documentation on
  [STREME](https://meme-suite.org/meme/doc/streme.html).

## Value

A list of
[`universalmotif`](https://rdrr.io/pkg/universalmotif/man/universalmotif-class.html)
objects and associated metadata.

## Examples

``` r
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
#> Warning: p-values will be inaccurate if primary and control
#> Warning: p-values will be inaccurate if primary and control
#> [1] "TCCCAKMACN"
```
