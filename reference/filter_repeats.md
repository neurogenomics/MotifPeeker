# Filter motifs with nucleotide repeats

Filter out motifs which contain `filter_n` or more consecutive
nucleotide repeats. This includes unambiguous bases such as 'Y', 'N,
'R', etc.

## Usage

``` r
filter_repeats(motifs, filter_n = 6)
```

## Arguments

- motifs:

  Output from
  [`runStreme`](https://rdrr.io/pkg/memes/man/runStreme.html).

- filter_n:

  Minimum number of consecutive nucleotide repeats to filter.

## Value

A list object with same structure as `motifs` but with motifs containing
`filter_n` or more consecutive nucleotide repeats removed.

## See also

[`runStreme`](https://rdrr.io/pkg/memes/man/runStreme.html)
