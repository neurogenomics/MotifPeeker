# Plot motif-enrichment for all experiments

Visualises the result from
[`get_df_enrichment`](https://neurogenomics.github.io/MotifPeeker/reference/get_df_enrichment.md)
for a single motif by producing a `plotly` bar plot with the motif
enrichment comparisons for all the comparison dataset pair.

## Usage

``` r
plot_enrichment_overall(
  enrichment_df,
  motif_i,
  label_colours,
  reference_label,
  html_tags = TRUE
)
```

## Arguments

- enrichment_df:

  A data frame containing the motif enrichment results, produced using
  [`get_df_enrichment`](https://neurogenomics.github.io/MotifPeeker/reference/get_df_enrichment.md).

- motif_i:

  The index of the motif to plot.

- label_colours:

  A vector with colours (valid names or hex codes) to use for "No" and
  "Yes" bar segments.

- reference_label:

  The label of the reference experiment.

- html_tags:

  Logical. If TRUE, returns the plot as a `tagList` object.

## Value

A list of `plotly` objects with the peak motif enrichment data. If
`html_tags` is `TRUE`, the function returns a list of `tagList` objects
instead. The two plots in the list are named as follows:

- `$count_plt`:

  y-axis represents the number of peaks.

- `$perc_plt`:

  y-axis represents the percentage of peaks.

## See also

Other plot functions:
[`plot_enrichment_individual()`](https://neurogenomics.github.io/MotifPeeker/reference/plot_enrichment_individual.md),
[`plot_motif_comparison()`](https://neurogenomics.github.io/MotifPeeker/reference/plot_motif_comparison.md)
