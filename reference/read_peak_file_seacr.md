# Read SEACR BED peak file

This function reads a SEACR BED peak file and returns a GRanges object
with the peak coordinates and summit.

## Usage

``` r
read_peak_file_seacr(peak_file)
```

## Arguments

- peak_file:

  A character string with the path to the peak file, or a GRanges object
  created using
  [`read_peak_file()`](https://neurogenomics.github.io/MotifPeeker/reference/read_peak_file.md).

## Value

A
[GRanges-class](https://rdrr.io/pkg/GenomicRanges/man/GRanges-class.html)
object with the peak coordinates and summit.

## Details

The *summit* column is the absolute genomic position of the peak, which
is relative to the start position of the sequence range. For SEACR BED
files, the *summit* column is calculated as the midpoint of the max
signal region.

## See also

[GRanges-class](https://rdrr.io/pkg/GenomicRanges/man/GRanges-class.html)
for more information on GRanges objects.
