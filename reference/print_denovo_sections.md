# Print denovo motif enrichment [`datatable`](https://rdrr.io/pkg/DT/man/datatable.html) and download buttons for related files.

Print denovo motif enrichment
[`datatable`](https://rdrr.io/pkg/DT/man/datatable.html) and download
buttons for related files.

## Usage

``` r
print_denovo_sections(
  motif_list,
  similar_motifs,
  segregated_peaks,
  indices,
  jaspar_link = FALSE,
  download_buttons = NULL
)
```

## Arguments

- motif_list:

  A list of motifs discovered by
  [`find_motifs`](https://neurogenomics.github.io/MotifPeeker/reference/find_motifs.md),
  for one comparison pair.

- similar_motifs:

  A list of similar motifs discovered using
  [`motif_similarity`](https://neurogenomics.github.io/MotifPeeker/reference/motif_similarity.md),
  for one comparison pair.

- segregated_peaks:

  A list of peaks segregated by common and unique groups, for one
  comparison pair.

- indices:

  A list of indices to print the `datatable` and download buttons for.

- jaspar_link:

  A logical indicating whether to include a link to the JASPAR database
  for the motifs. Only set to `TRUE` if the motifs are in JASPAR format
  (example: "MA1930.1").

- download_buttons:

  Embed download buttons generated using
  [`get_download_buttons`](https://neurogenomics.github.io/MotifPeeker/reference/get_download_buttons.md).
  If set to `NULL`, no download buttons will be added.

## Value

Null

## See also

Other datatable functions:
[`dt_enrichment_individual()`](https://neurogenomics.github.io/MotifPeeker/reference/dt_enrichment_individual.md)
