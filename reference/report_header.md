# Report header

Credit: This function was adapted from the *EpiCompare* package.

## Usage

``` r
report_header()
```

## Value

Header string to be rendering within Rmarkdown file.

## Details

Generate a header for
[MotifPeeker](https://neurogenomics.github.io/MotifPeeker/reference/MotifPeeker.md)
reports generated using the *MotifPeeker.Rmd* template.

## Examples

``` r
MotifPeeker:::report_header()
#> [1] "<div class='report-header'><a href='https://github.com/neurogenomics/MotifPeeker' target='_blank'><code>MotifPeeker</code></a><code>Report</code><a href='https://github.com/neurogenomics/MotifPeeker' target='_blank'><img src='/__w/_temp/Library/MotifPeeker/hex/hex.png' height='100'></a><br><span style='font-size: 0.4em; color: #827594; margin-top: -1.6em; margin-left: 0.4em; margin-bottom: 3em; display: block;'>version 1.3.1</span></div>"
```
