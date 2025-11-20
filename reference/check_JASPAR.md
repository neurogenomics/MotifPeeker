# Check for JASPAR input

Check and get files from JASPAR. Requires the input to be in JASPAR ID
format. Uses BiocFileCache to cache downloads.

## Usage

``` r
check_JASPAR(motif_id, verbose = FALSE)
```

## Arguments

- motif_id:

  A character string specifying the JASPAR motif ID.

- verbose:

  A logical indicating whether to print verbose messages while running
  the function. (default = FALSE)

## Value

A character string specifying the path to the downloaded file.

## Examples

``` r
check_JASPAR("MA1930.2")
#>                                                               BFC3 
#> "/github/home/.cache/R/BiocFileCache/1cc0171dc5b2_MA1930.2.jaspar" 
```
