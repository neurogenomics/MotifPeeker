# Plot motif-enrichment for individual experiments

Visualises the result from
[`get_df_enrichment`](https://neurogenomics.github.io/MotifPeeker/reference/get_df_enrichment.md)
for a single motif by producing a `plotly` bar plot with the motif
enrichment comparisons for one comparison dataset pair.

## Usage

``` r
plot_enrichment_individual(
  result,
  enrichment_df,
  comparison_i,
  motif_i,
  label_colours,
  reference_index = 1,
  html_tags = TRUE
)
```

## Arguments

- result:

  A `list` with the following elements:

  peaks

  :   A `list` of peak files generated using
      [`read_peak_file`](https://neurogenomics.github.io/MotifPeeker/reference/read_peak_file.md).

  alignments

  :   A `list` of alignment files.

  exp_type

  :   A `character` vector of experiment types.

  exp_labels

  :   A `character` vector of experiment labels.

  read_count

  :   A `numeric` vector of read counts.

  peak_count

  :   A `numeric` vector of peak counts.

- enrichment_df:

  A data frame containing the motif enrichment results, produced using
  [`get_df_enrichment`](https://neurogenomics.github.io/MotifPeeker/reference/get_df_enrichment.md).

- comparison_i:

  The index of the comparison dataset to plot.

- motif_i:

  The index of the motif to plot.

- label_colours:

  A vector with colours (valid names or hex codes) to use for "No" and
  "Yes" bar segments.

- reference_index:

  An integer specifying the index of the peak file to use as the
  reference dataset for comparison. Indexing starts from 1. (default =
  1)

- html_tags:

  Logical. If TRUE, returns the plot as a `tagList` object.

## Value

A `plotly` object with the peak motif enrichment data. If `html_tags` is
`TRUE`, the function returns a `tagList` object instead.

## See also

Other plot functions:
[`plot_enrichment_overall()`](https://neurogenomics.github.io/MotifPeeker/reference/plot_enrichment_overall.md),
[`plot_motif_comparison()`](https://neurogenomics.github.io/MotifPeeker/reference/plot_motif_comparison.md)
