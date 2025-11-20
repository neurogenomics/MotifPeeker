# Download JASPAR CORE database

Downloads JASPAR CORE database in `meme` format for all available
taxonomic groups. Uses BiocFileCache to cache downloads.

## Usage

``` r
get_JASPARCORE(verbose = FALSE)
```

## Arguments

- verbose:

  A logical indicating whether to print verbose messages while running
  the function. (default = FALSE)

## Value

A character string specifying the path to the downloaded file (`meme`
format).

## Examples

``` r
get_JASPARCORE()
#>                                                                                           BFC1 
#> "/github/home/.cache/R/BiocFileCache/1be0525e9d0c_JASPAR2024_CORE_non-redundant_pfms_meme.txt" 
```
