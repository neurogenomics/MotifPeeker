# Check attached dependency

Stop execution if a package is not attached.

## Usage

``` r
check_dep(pkg, fatal = TRUE, custom_msg = NULL)
```

## Arguments

- pkg:

  a character string of the package name

- fatal:

  a logical value indicating whether to stop execution if the package is
  not attached.

- custom_msg:

  a custom message to display if the package is not attached.

## Value

TRUE if the package is available or else FALSE if `fatal = FALSE`.
