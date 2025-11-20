# Convert numbers to more readable strings

Format raw numbers to more readable strings. For example, 1000 will be
converted to "1K". Supported suffixes are "K", "M", and "B".

## Usage

``` r
pretty_number(x, decimal_digits = 2)
```

## Arguments

- x:

  A number.

- decimal_digits:

  Number of decimal digits to round to.

## Value

A character string of the formatted number. `NA` is returned as "NA".

## Examples

``` r
print(MotifPeeker:::pretty_number(134999))
#> [1] "135K"
```
