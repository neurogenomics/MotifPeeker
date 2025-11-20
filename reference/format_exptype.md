# Format exp_type

Format input exp_type to look pretty.

## Usage

``` r
format_exptype(exp_type)
```

## Arguments

- exp_type:

  A character depicting the type of experiment. Supported experimental
  types are:

  - `chipseq`: ChIP-seq data

  - `tipseq`: TIP-seq data

  - `cuttag`: CUT&Tag data

  - `cutrun`: CUT&Run data

  - `other`: Other experiment type data

  - `unknown`: Unknown experiment type data

  Any item not mentioned above will be returned as-is.

## Value

A character vector of formatted exp_type.

## Examples

``` r
MotifPeeker:::format_exptype("chipseq")
#> [1] "ChIP-Seq"
```
