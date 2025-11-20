# Use BiocParallel functions with appropriate parameters

Light wrapper around
[`BiocParallel`](https://rdrr.io/pkg/BiocParallel/man/BiocParallel-package.html)
functions that automatically applies appropriate parallel function.

## Usage

``` r
bpapply(
  X,
  FUN,
  apply_fun = BiocParallel::bplapply,
  BPPARAM = BiocParallel::bpparam(),
  progressbar = FALSE,
  force_snowparam = FALSE,
  verbose = FALSE,
  ...
)
```

## Arguments

- X:

  Any object for which methods `length`, `[`, and `[[` are implemented.

- FUN:

  The `function` to be applied to each element of `X`.

- apply_fun:

  A
  [`BiocParallel`](https://rdrr.io/pkg/BiocParallel/man/BiocParallel-package.html)
  function to use for parallel processing. (default =
  [`BiocParallel::bplapply`](https://rdrr.io/pkg/BiocParallel/man/bplapply.html))

- BPPARAM:

  A
  [`BiocParallelParam-class`](https://rdrr.io/pkg/BiocParallel/man/BiocParallelParam-class.html)
  object specifying run parameters. (default = bpparam())

- ...:

  Arguments passed on to
  [`BiocParallel::bplapply`](https://rdrr.io/pkg/BiocParallel/man/bplapply.html),
  [`BiocParallel::bpmapply`](https://rdrr.io/pkg/BiocParallel/man/bpmapply.html)

  `BPREDO`

  :   A `list` of output from `bplapply` with one or more failed
      elements. When a list is given in `BPREDO`, `bpok` is used to
      identify errors, tasks are rerun and inserted into the original
      results.

  `BPOPTIONS`

  :   Additional options to control the behavior of the parallel
      evaluation, see
      [`bpoptions`](https://rdrr.io/pkg/BiocParallel/man/bpoptions.html).

  `MoreArgs`

  :   List of additional arguments to `FUN`.

  `SIMPLIFY`

  :   If `TRUE` the result will be simplified using
      [`simplify2array`](https://rdrr.io/r/base/lapply.html).

  `USE.NAMES`

  :   If `TRUE` the result will be named.

## Value

Output relevant to the `apply_fun` specified.

## Examples

``` r
half_it <- function(arg1) return(arg1 / 2)
x <- seq_len(10)

res <- MotifPeeker:::bpapply(x, half_it)
print(res)
#> [[1]]
#> [1] 0.5
#> 
#> [[2]]
#> [1] 1
#> 
#> [[3]]
#> [1] 1.5
#> 
#> [[4]]
#> [1] 2
#> 
#> [[5]]
#> [1] 2.5
#> 
#> [[6]]
#> [1] 3
#> 
#> [[7]]
#> [1] 3.5
#> 
#> [[8]]
#> [1] 4
#> 
#> [[9]]
#> [1] 4.5
#> 
#> [[10]]
#> [1] 5
#> 
```
