# Report command

Reconstruct the
[`MotifPeeker`](https://neurogenomics.github.io/MotifPeeker/reference/MotifPeeker.md)
command from the parameters used to generate the HTML report.

## Usage

``` r
report_command(params)
```

## Arguments

- params:

  A list of parameters used to generate the HTML report.

## Value

A character string containing the reconstructed
[`MotifPeeker`](https://neurogenomics.github.io/MotifPeeker/reference/MotifPeeker.md)
command.

## Examples

``` r
MotifPeeker:::report_command(params = list(
   alignment_files = c("file1.bam", "file2.bam"),
   exp_labels = c("exp1", "exp2"),
   genome_build = "hg19"))
#> [1] "<pre><code class='language-r'>MotifPeeker(alignment_files = list(\"file1.bam\", \"file2.bam\"),\n            exp_labels = list(\"exp1\", \"exp2\"),\n            genome_build = \"hg19\")</code></pre>"
```
