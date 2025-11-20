# Check, add and access files in cache

Query local BiocFileCache to get cached version of a file and add them
if they do not exist.

## Usage

``` r
use_cache(url, verbose = FALSE)
```

## Arguments

- url:

  A character string specifying the URL of the file to check for.

- verbose:

  A logical indicating whether to print verbose messages while running
  the function. (default = FALSE)

## Value

A character string specifying the path to the cached file.
