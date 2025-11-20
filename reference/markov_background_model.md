# Generate a 0-order Markov background model

`markov_background_model()` generates a 0-order background model for use
with FIMO or AME. The function uses the letter frequencies in the input
sequences to generate the background model.

## Usage

``` r
markov_background_model(sequences, out_dir, verbose = FALSE)
```

## Arguments

- sequences:

  A DNAStringSet object.

- out_dir:

  Location to save the 0-order background file.

- verbose:

  A logical indicating whether to print verbose messages while running
  the function. (default = FALSE)

## Value

The path to the 0-order background file.
