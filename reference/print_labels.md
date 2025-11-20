# Print the labels of the reference and comparison experiments

Print the labels of the reference and comparison experiments

## Usage

``` r
print_labels(
  exp_labels,
  reference_index,
  comparison_index,
  header_type,
  read_counts = NULL
)
```

## Arguments

- exp_labels:

  A character vector of experiment labels.

- reference_index:

  The index of the reference experiment.

- comparison_index:

  The index of the comparison experiment.

- header_type:

  Label for the section to print the header for. Options are:
  "known_motif" and "denovo_motif".

- read_counts:

  A numeric vector of read counts for each experiment. (optional)

## Value

String with the labels of the reference and comparison experiments.
