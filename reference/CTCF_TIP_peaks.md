# Example TIP-seq peak file

Human CTCF peak file generated with TIP-seq using HCT116 cell-line. The
peak file was generated using the
[nf-core/cutandrun](https://nf-co.re/cutandrun/3.2.2) pipeline. Raw read
files were sourced from *NIH Sequence Read Archives* (ID:
[SRR16963166](https://trace.ncbi.nlm.nih.gov/Traces/index.html?view=run_browser&acc=SRR16963166)).

## Usage

``` r
data("CTCF_TIP_peaks")
```

## Format

An object of class `GRanges` of length 182.

## Note

To reduce the size of the package, the included peak file focuses on
specific genomic regions. The subset region included is
chr10:65,654,529-74,841,155.
