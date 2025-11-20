# Calculate FRiP score

Calculate the Fraction of Reads in Peak score from the read and peak
file of an experiment.

## Usage

``` r
calc_frip(read_file, peak_file, single_end = TRUE, total_reads = NULL)
```

## Arguments

- read_file:

  A BamFile object.

- peak_file:

  A GRanges object.

- single_end:

  A logical value. If TRUE, the reads classified as single-ended.
  (default = TRUE)

- total_reads:

  (optional) The total number of reads in the experiment. Skips counting
  the total number of reads if provided, saving computation.

## Value

A numeric value indicating the FRiP score.

## Details

The FRiP score is calculated as follows: \$\$\text{FRiP} =
\frac{(\text{number of reads in peaks})}{\text{(total number of
reads)}}\$\$

## Examples

``` r
read_file <- system.file("extdata", "CTCF_ChIP_alignment.bam",
                        package = "MotifPeeker")
read_file <- Rsamtools::BamFile(read_file)
data("CTCF_ChIP_peaks", package = "MotifPeeker")

calc_frip(read_file, CTCF_ChIP_peaks)
#> [1] 0.2473209
```
