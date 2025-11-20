# Check for ENCODE input

Check and get files from ENCODE project. Requires the input to be in
ENCODE ID format. Uses BiocFileCache to cache downloads. Only works for
files.

## Usage

``` r
check_ENCODE(encode_id, expect_format, verbose = FALSE)
```

## Arguments

- encode_id:

  A character string specifying the ENCODE ID.

- expect_format:

  A character string (or a vector) specifying the expected format(s) of
  the file. If the file is not in the expected format, an error is
  thrown.

- verbose:

  A logical indicating whether to print verbose messages while running
  the function. (default = FALSE)

## Value

A character string specifying the path to the downloaded file.

## Examples

``` r
if (requireNamespace("curl", quietly = TRUE) &&
    requireNamespace("jsonlite", quietly = TRUE)) {
    check_ENCODE("ENCFF920TXI", expect_format = c("bed", "gz"))
}
#>                                                                  BFC2 
#> "/github/home/.cache/R/BiocFileCache/1be032643245_ENCFF920TXI.bed.gz" 
```
