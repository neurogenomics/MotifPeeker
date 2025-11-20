# Read MACS2/3 narrowPeak or SEACR BED peak file

This function reads a MACS2/3 narrowPeak or SEACR BED peak file and
returns a GRanges object with the peak coordinates and summit.

## Usage

``` r
read_peak_file(peak_file, file_format = "auto", verbose = FALSE)
```

## Arguments

- peak_file:

  A character string with the path to the peak file, or a GRanges object
  created using `read_peak_file()`.

- file_format:

  A character string specifying the format of the peak file.

  - `"narrowpeak"`: MACS2/3 narrowPeak format.

  - `"bed"`: SEACR BED format.

- verbose:

  A logical indicating whether to print messages.

## Value

A
[GRanges-class](https://rdrr.io/pkg/GenomicRanges/man/GRanges-class.html)
object with the peak coordinates and summit.

## Details

The *summit* column is the absolute genomic position of the peak, which
is relative to the start position of the sequence range. For SEACR BED
files, the *summit* column is calculated as the midpoint of the max
signal region.

## See also

[GRanges-class](https://rdrr.io/pkg/GenomicRanges/man/GRanges-class.html)
for more information on GRanges objects.

## Examples

``` r
macs3_peak_file <- system.file("extdata", "CTCF_ChIP_peaks.narrowPeak",
package = "MotifPeeker")
macs3_peak_read <- read_peak_file(macs3_peak_file)
macs3_peak_read
#> GRanges object with 209 ranges and 7 metadata columns:
#>                    seqnames            ranges strand |             name
#>                       <Rle>         <IRanges>  <Rle> |      <character>
#>     ChIPseq_peak_1    chr10 65672891-65673094      * |   ChIPseq_peak_1
#>     ChIPseq_peak_2    chr10 66112133-66112279      * |   ChIPseq_peak_2
#>     ChIPseq_peak_3    chr10 66180787-66181041      * |   ChIPseq_peak_3
#>     ChIPseq_peak_4    chr10 66215124-66215282      * |   ChIPseq_peak_4
#>     ChIPseq_peak_5    chr10 66277566-66277829      * |   ChIPseq_peak_5
#>                ...      ...               ...    ... .              ...
#>   ChIPseq_peak_205    chr10 74244202-74244399      * | ChIPseq_peak_205
#>   ChIPseq_peak_206    chr10 74266052-74266297      * | ChIPseq_peak_206
#>   ChIPseq_peak_207    chr10 74419925-74420183      * | ChIPseq_peak_207
#>   ChIPseq_peak_208    chr10 74738977-74739145      * | ChIPseq_peak_208
#>   ChIPseq_peak_209    chr10 74826600-74826822      * | ChIPseq_peak_209
#>                        score signalValue    pValue    qValue      peak
#>                    <numeric>   <numeric> <numeric> <numeric> <integer>
#>     ChIPseq_peak_1       132     9.71581  16.61240  13.21760        91
#>     ChIPseq_peak_2        47     5.72046   7.95781   4.74195        77
#>     ChIPseq_peak_3       250    13.60270  28.62760  25.05950       117
#>     ChIPseq_peak_4        98     7.90847  13.19130   9.85816        52
#>     ChIPseq_peak_5       343    16.08460  38.04630  34.35700       126
#>                ...       ...         ...       ...       ...       ...
#>   ChIPseq_peak_205       144     9.44644  17.88500  14.46760        91
#>   ChIPseq_peak_206       613    21.78070  65.40130  61.39370       110
#>   ChIPseq_peak_207       457    18.43810  49.55520  45.72990       134
#>   ChIPseq_peak_208        66     6.52919   9.93714   6.66903        96
#>   ChIPseq_peak_209       192    11.78170  22.77100  19.28080       112
#>                       summit
#>                    <integer>
#>     ChIPseq_peak_1  65672982
#>     ChIPseq_peak_2  66112210
#>     ChIPseq_peak_3  66180904
#>     ChIPseq_peak_4  66215176
#>     ChIPseq_peak_5  66277692
#>                ...       ...
#>   ChIPseq_peak_205  74244293
#>   ChIPseq_peak_206  74266162
#>   ChIPseq_peak_207  74420059
#>   ChIPseq_peak_208  74739073
#>   ChIPseq_peak_209  74826712
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```
