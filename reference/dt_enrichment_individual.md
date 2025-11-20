# Get [`datatable`](https://rdrr.io/pkg/DT/man/datatable.html) for motif-enrichment of individual experiments.

Get [`datatable`](https://rdrr.io/pkg/DT/man/datatable.html) for
motif-enrichment of individual experiments.

## Usage

``` r
dt_enrichment_individual(
  result,
  enrichment_df,
  comparison_i,
  motif_i,
  reference_index = 1
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

- reference_index:

  An integer specifying the index of the peak file to use as the
  reference dataset for comparison. Indexing starts from 1. (default =
  1)

## Value

A [`DT::datatable`](https://rdrr.io/pkg/DT/man/datatable.html) object
with the peak motif enrichment data for the specified `comparison_i` and
`motif_i`.

## See also

Other datatable functions:
[`print_denovo_sections()`](https://neurogenomics.github.io/MotifPeeker/reference/print_denovo_sections.md)
