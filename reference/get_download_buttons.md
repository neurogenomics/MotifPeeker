# Get download buttons for peak file, STREME and TOMOTM output

Get download buttons for peak file, STREME and TOMOTM output

## Usage

``` r
get_download_buttons(
  comparison_i,
  start_i,
  segregated_peaks,
  out_dir,
  add_buttons = TRUE,
  verbose = FALSE
)
```

## Arguments

- comparison_i:

  Index of the comparison pair group.

- start_i:

  Index of the first comparison pair.

- segregated_peaks:

  A list of peak files generated from
  [`segregate_seqs`](https://neurogenomics.github.io/MotifPeeker/reference/segregate_seqs.md).

- out_dir:

  A character vector of the directory with STREME and TOMTOM output.

- add_buttons:

  A logical indicating whether to prepare download buttons.

- verbose:

  A logical indicating whether to print messages.

## Value

A list of download buttons for peak file, STREME and TOMTOM output.
