# Trim sequences to a specified width around the summit

Trim sequences to a specified width around the summit

## Usage

``` r
trim_seqs(peaks, peak_width, genome_build, respect_bounds = TRUE)
```

## Arguments

- peaks:

  A GRanges object created using
  [`read_peak_file()`](https://neurogenomics.github.io/MotifPeeker/reference/read_peak_file.md).

- peak_width:

  Total expected width of the peak.

- genome_build:

  The genome build that the peak sequences should be derived from.

- respect_bounds:

  Logical indicating whether the peak width should be respected when
  trimming sequences. (default = TRUE) If `TRUE`, the trimmed sequences
  will not extend beyond the peak boundaries.

## Value

A GRanges object with the trimmed sequences. The sequences are
guaranteed to not exceed the `peak width + 1` (peak width + the summit
base).

## Examples

``` r
data("CTCF_TIP_peaks", package = "MotifPeeker")
peaks <- CTCF_TIP_peaks
genome_build <- BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38

trimmed_seqs <- MotifPeeker:::trim_seqs(peaks, peak_width = 100,
                         genome_build = genome_build)
summary(GenomicRanges::width(trimmed_seqs))
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#>    59.0   101.0   101.0    98.5   101.0   101.0 
```
