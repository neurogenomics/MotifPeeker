# Bootstrap motif-summit distances for one set of peaks and one motif

This function performs bootstrapping to estimate the distribution of
mean absolute distances between peak summits and motif positions for a
given set of peaks and a specified motif.

## Usage

``` r
bootstrap_distances(
  peaks,
  motif,
  genome_build,
  samples_n = NULL,
  samples_len = NULL,
  out_dir = tempdir(),
  meme_path = NULL,
  verbose = FALSE
)
```

## Arguments

- peaks:

  A `GRanges` object containing peak ranges.

- motif:

  A `universalmotif` object.

- genome_build:

  A `BSgenome` object representing the genome build.

- samples_n:

  An integer specifying the number of bootstrap samples to generate. If
  `NULL`, it is set to 70% of the number of peaks.

- samples_len:

  An integer specifying the number of peaks to sample in each bootstrap
  iteration. If `NULL`, it is set to 20 peaks.

- out_dir:

  Location to save the 0-order background file. By default, the
  background file will be written to a temporary directory.

- meme_path:

  path to "meme/bin/" (default: `NULL`). Will use default search
  behavior as described in `check_meme_install()` if unset.

- verbose:

  A logical indicating whether to print verbose messages while running
  the function. (default = FALSE)

## Value

A `numeric` vector of bootstrapped mean absolute distances between peak
summits and motif positions with length equal to `samples_n`.

## Examples

``` r
if (memes::meme_is_installed()) {
    peak <- system.file("extdata", "CTCF_ChIP_peaks.narrowPeak",
                package = "MotifPeeker") |>
                read_peak_file() |>
                sample(20)
    motif <- system.file("extdata", "motif_MA1102.3.jaspar",
                package = "MotifPeeker") |> read_motif_file()
                
    if (requireNamespace("BSgenome.Hsapiens.UCSC.hg38")) {
        genome_build <-
            BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
            
        distances <- bootstrap_distances(
            peak = peak,
            motif = motif,
            genome_build = genome_build,
            samples_n = 2,
            samples_len = NULL,
            verbose = FALSE
        )
        print(distances)
    }
}
#> No matches were detected
#> No matches were detected
#> [1] NA NA
```
