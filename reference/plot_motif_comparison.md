# Produce heat maps of motif similarity matrices

Produce heat maps of motif similarity matrices

## Usage

``` r
plot_motif_comparison(
  comparison_matrices,
  exp_labels,
  height = NULL,
  width = NULL,
  html_tags = TRUE
)
```

## Arguments

- comparison_matrices:

  Output from
  [`compare_motifs`](https://rdrr.io/pkg/universalmotif/man/compare_motifs.html)
  for one comparison pair (Four matrices).

- exp_labels:

  Labels for the reference and comparison experiments respectively.

- width, height:

  The width and height of the output htmlwidget, or the output file if
  exporting to png/pdf/etc. Presumed to be in pixels, but if a plotly
  internal function decides it's in other units you may end up with a
  huge file! Default is 800x500 when exporting to a file, and 100 as a
  htmlwidget.

- html_tags:

  Logical. If TRUE, returns the plot as a `tagList` object.

## Value

A list of individual heat maps for the four matrices. If `html_tags` is
`TRUE`, the output will be wrapped in HTML tags.

## See also

Other plot functions:
[`plot_enrichment_individual()`](https://neurogenomics.github.io/MotifPeeker/reference/plot_enrichment_individual.md),
[`plot_enrichment_overall()`](https://neurogenomics.github.io/MotifPeeker/reference/plot_enrichment_overall.md)
