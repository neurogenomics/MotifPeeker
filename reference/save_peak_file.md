# Minimally save a peak object to a file (BED4)

This function saves a peak object to a file in BED4 format. The included
columns are: `chr`, `start`, `end`, and `name`. Since no strand data is
being included, it is recommended to use this function only for peak
objects that do not have strand information.

## Usage

``` r
save_peak_file(
  peak_obj,
  save = TRUE,
  filename = random_string(10),
  out_dir = tempdir()
)
```

## Arguments

- peak_obj:

  A GRanges object with the peak coordinates. Must include columns:
  `seqnames`, `start`, `end`, and `name`.

- save:

  A logical indicating whether to save the peak object to a file.

- filename:

  A character string of the file name. If the file extension is not
  `.bed`, a warning is issued and the extension is appended.
  Alternatively, if the file name does not have an extension, `.bed` is
  appended. (default = random string)

- out_dir:

  A character string of the output directory. (default = tempdir())

## Value

If `save = FALSE`, a data frame with the peak coordinates. If
`save = TRUE`, the path to the saved file.

## Examples

``` r
data("CTCF_ChIP_peaks", package = "MotifPeeker")

out <- save_peak_file(CTCF_ChIP_peaks, save = TRUE, "test_peak_file.bed")
print(out)
#> [1] "/tmp/RtmpJUDOew/test_peak_file.bed"
```
