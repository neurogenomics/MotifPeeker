# Get dataframe with motif-summit distances

Wrapper for \`MotifPeeker::summit_to_motif\` to get motif-summit
distances for all peaks and motifs, generating a `data.frame` suitable
for plots.

## Usage

``` r
get_df_distances(
  result,
  user_motifs,
  genome_build,
  out_dir = tempdir(),
  BPPARAM = BiocParallel::bpparam(),
  meme_path = NULL,
  verbose = FALSE
)
```

## Arguments

- result:

  A `list` with the following elements:

  peaks

  :   A `list` of peak files generated using
      [`read_peak_file`](https://neurogenomics.github.io/MotifPeeker/reference/read_peak_file.md).

  alignments

  :   A `list` of alignment files.

  exp_type

  :   A `character` vector of experiment types.

  exp_labels

  :   A `character` vector of experiment labels.

  read_count

  :   A `numeric` vector of read counts.

  peak_count

  :   A `numeric` vector of peak counts.

- user_motifs:

  A `list` with the following elements:

  motifs

  :   A `list` of motif files.

  motif_labels

  :   A `character` vector of motif labels.

- genome_build:

  A character string with the abbreviated genome build name, or a
  BSGenome object. Check
  [check_genome_build](https://neurogenomics.github.io/MotifPeeker/reference/check_genome_build.md)
  details for genome builds which can be imported as abbreviated names.

- out_dir:

  A `character` vector of output directory.

- BPPARAM:

  A
  [`BiocParallelParam-class`](https://rdrr.io/pkg/BiocParallel/man/BiocParallelParam-class.html)
  object enabling parallel execution. (default = SerialParam(),
  single-CPU run)  
    
  Following are two examples of how to set up parallel processing:

  - `BPPARAM = BiocParallel::MulticoreParam(4)`: Uses 4 CPU cores for
    parallel processing.

  - [`library("BiocParallel")`](https://github.com/Bioconductor/BiocParallel)
    followed by `register(MulticoreParam(4))` sets all subsequent
    BiocParallel functions to use 4 CPU cores. `Motifpeeker()` must be
    run with `BPPARAM = BiocParallel::MulticoreParam()`.

  **IMPORTANT:** For each worker, please ensure a minimum of 8GB of
  memory (RAM) is available as `motif_discovery` is memory-intensive.

- meme_path:

  path to `meme/bin/` (optional). Defaut: `NULL`, searches "MEME_PATH"
  environment variable or "meme_path" option for path to "meme/bin/".

- verbose:

  A logical indicating whether to print verbose messages while running
  the function. (default = FALSE)

## Value

A `data.frame` with the following columns:

- exp_label:

  Experiment labels.

- exp_type:

  Experiment types.

- motif_indice:

  Motif indices.

- distance:

  Distances between peak summit and motif.

## See also

Other generate data.frames:
[`get_df_distances_bootstrapped()`](https://neurogenomics.github.io/MotifPeeker/reference/get_df_distances_bootstrapped.md),
[`get_df_enrichment()`](https://neurogenomics.github.io/MotifPeeker/reference/get_df_enrichment.md)

## Examples

``` r
if (memes::meme_is_installed()) {
data("CTCF_ChIP_peaks", package = "MotifPeeker")
data("motif_MA1102.3", package = "MotifPeeker")
data("motif_MA1930.2", package = "MotifPeeker")
input <- list(
    peaks = CTCF_ChIP_peaks,
    exp_type = "ChIP",
    exp_labels = "CTCF",
    read_count = 150,
    peak_count = 100
)
motifs <- list(
    motifs = list(motif_MA1930.2, motif_MA1102.3),
    motif_labels = list("MA1930.2", "MA1102.3")
)

if (requireNamespace("BSgenome.Hsapiens.UCSC.hg38")) {
    genome_build <- BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
    distances_df <- get_df_distances(input, motifs, genome_build)
    print(distances_df)
}
}
#>     exp_label exp_type motif_indice distance
#> 1        CTCF     ChIP            1     24.0
#> 2        CTCF     ChIP            1    -26.0
#> 3        CTCF     ChIP            1    -20.0
#> 4        CTCF     ChIP            1     21.0
#> 5        CTCF     ChIP            1     -3.0
#> 6        CTCF     ChIP            1    -18.0
#> 7        CTCF     ChIP            1     14.0
#> 8        CTCF     ChIP            1      2.0
#> 9        CTCF     ChIP            1    -20.0
#> 10       CTCF     ChIP            1     17.0
#> 11       CTCF     ChIP            1    -27.0
#> 12       CTCF     ChIP            1     -4.0
#> 13       CTCF     ChIP            1      5.0
#> 14       CTCF     ChIP            1    -17.0
#> 15       CTCF     ChIP            1      8.0
#> 16       CTCF     ChIP            1    -13.0
#> 17       CTCF     ChIP            1     -5.0
#> 18       CTCF     ChIP            1     14.0
#> 19       CTCF     ChIP            1     25.0
#> 20       CTCF     ChIP            1      0.0
#> 21       CTCF     ChIP            1     14.0
#> 22       CTCF     ChIP            1    -29.0
#> 23       CTCF     ChIP            1   -245.0
#> 24       CTCF     ChIP            1      3.0
#> 25       CTCF     ChIP            1     16.0
#> 26       CTCF     ChIP            1    -32.0
#> 27       CTCF     ChIP            1     28.0
#> 28       CTCF     ChIP            1    -22.0
#> 29       CTCF     ChIP            1     -5.0
#> 30       CTCF     ChIP            1     -7.0
#> 31       CTCF     ChIP            1      2.0
#> 32       CTCF     ChIP            1     -9.0
#> 33       CTCF     ChIP            1   -116.0
#> 34       CTCF     ChIP            1     11.0
#> 35       CTCF     ChIP            1      1.0
#> 36       CTCF     ChIP            1    -82.0
#> 37       CTCF     ChIP            1    -22.0
#> 38       CTCF     ChIP            1     -3.0
#> 39       CTCF     ChIP            1     45.0
#> 40       CTCF     ChIP            1      5.0
#> 41       CTCF     ChIP            1     -3.0
#> 42       CTCF     ChIP            1      9.0
#> 43       CTCF     ChIP            1     -7.0
#> 44       CTCF     ChIP            1   -168.0
#> 45       CTCF     ChIP            1    119.0
#> 46       CTCF     ChIP            1     74.0
#> 47       CTCF     ChIP            1     -1.0
#> 48       CTCF     ChIP            1      2.0
#> 49       CTCF     ChIP            1    -26.0
#> 50       CTCF     ChIP            1     15.0
#> 51       CTCF     ChIP            1      1.0
#> 52       CTCF     ChIP            1     -9.0
#> 53       CTCF     ChIP            1    -70.0
#> 54       CTCF     ChIP            1      1.0
#> 55       CTCF     ChIP            1     22.0
#> 56       CTCF     ChIP            1    -95.0
#> 57       CTCF     ChIP            1    -13.0
#> 58       CTCF     ChIP            1     16.0
#> 59       CTCF     ChIP            1     30.0
#> 60       CTCF     ChIP            1      2.0
#> 61       CTCF     ChIP            1      2.0
#> 62       CTCF     ChIP            1    -31.0
#> 63       CTCF     ChIP            1     -9.0
#> 64       CTCF     ChIP            1    -53.0
#> 65       CTCF     ChIP            1    -64.0
#> 66       CTCF     ChIP            1   -115.0
#> 67       CTCF     ChIP            1     13.0
#> 68       CTCF     ChIP            1     -3.0
#> 69       CTCF     ChIP            1     -5.0
#> 70       CTCF     ChIP            1    -10.0
#> 71       CTCF     ChIP            1     34.0
#> 72       CTCF     ChIP            1    -21.0
#> 73       CTCF     ChIP            1     49.0
#> 74       CTCF     ChIP            1      6.0
#> 75       CTCF     ChIP            1    -24.0
#> 76       CTCF     ChIP            1      8.0
#> 77       CTCF     ChIP            1     -8.0
#> 78       CTCF     ChIP            1     -8.0
#> 79       CTCF     ChIP            1    -35.0
#> 80       CTCF     ChIP            1     12.0
#> 81       CTCF     ChIP            1      7.0
#> 82       CTCF     ChIP            1     12.0
#> 83       CTCF     ChIP            1    -21.0
#> 84       CTCF     ChIP            1    -24.0
#> 85       CTCF     ChIP            1     35.0
#> 86       CTCF     ChIP            1    -34.0
#> 87       CTCF     ChIP            1    -42.0
#> 88       CTCF     ChIP            1      4.0
#> 89       CTCF     ChIP            1    -46.0
#> 90       CTCF     ChIP            1    -24.0
#> 91       CTCF     ChIP            1      5.0
#> 92       CTCF     ChIP            1     -9.0
#> 93       CTCF     ChIP            1      0.0
#> 94       CTCF     ChIP            1     -9.0
#> 95       CTCF     ChIP            1    -11.0
#> 96       CTCF     ChIP            1      3.0
#> 97       CTCF     ChIP            1     -3.0
#> 98       CTCF     ChIP            1     -9.0
#> 99       CTCF     ChIP            1    -37.0
#> 100      CTCF     ChIP            1     11.0
#> 101      CTCF     ChIP            1    -15.0
#> 102      CTCF     ChIP            1      1.0
#> 103      CTCF     ChIP            1    -96.0
#> 104      CTCF     ChIP            1     -7.0
#> 105      CTCF     ChIP            1     -9.0
#> 106      CTCF     ChIP            1      1.0
#> 107      CTCF     ChIP            1     12.0
#> 108      CTCF     ChIP            1      7.0
#> 109      CTCF     ChIP            1    -19.0
#> 110      CTCF     ChIP            1    -22.0
#> 111      CTCF     ChIP            1     25.0
#> 112      CTCF     ChIP            1    -29.0
#> 113      CTCF     ChIP            1    -52.0
#> 114      CTCF     ChIP            2      6.5
#> 115      CTCF     ChIP            2    -14.5
#> 116      CTCF     ChIP            2     63.5
#> 117      CTCF     ChIP            2     17.5
#> 118      CTCF     ChIP            2   -122.5
#> 119      CTCF     ChIP            2   -126.5
#> 120      CTCF     ChIP            2     21.5
#> 121      CTCF     ChIP            2     -6.5
#> 122      CTCF     ChIP            2   -122.5
#> 123      CTCF     ChIP            2    -16.5
#> 124      CTCF     ChIP            2    -10.5
#> 125      CTCF     ChIP            2     -5.5
#> 126      CTCF     ChIP            2    -19.5
#> 127      CTCF     ChIP            2    -59.5
#> 128      CTCF     ChIP            2     -9.5
#> 129      CTCF     ChIP            2    -20.5
#> 130      CTCF     ChIP            2     11.5
#> 131      CTCF     ChIP            2    -20.5
#> 132      CTCF     ChIP            2      8.5
#> 133      CTCF     ChIP            2    -10.5
#> 134      CTCF     ChIP            2      5.5
#> 135      CTCF     ChIP            2    -79.5
#> 136      CTCF     ChIP            2      5.5
#> 137      CTCF     ChIP            2    -13.5
#> 138      CTCF     ChIP            2     90.5
#> 139      CTCF     ChIP            2      0.5
#> 140      CTCF     ChIP            2     -5.5
#> 141      CTCF     ChIP            2     33.5
#> 142      CTCF     ChIP            2     -2.5
#> 143      CTCF     ChIP            2     94.5
#> 144      CTCF     ChIP            2     87.5
#> 145      CTCF     ChIP            2    -24.5
#> 146      CTCF     ChIP            2     72.5
#> 147      CTCF     ChIP            2    -23.5
#> 148      CTCF     ChIP            2      2.5
#> 149      CTCF     ChIP            2      1.5
#> 150      CTCF     ChIP            2   -120.5
#> 151      CTCF     ChIP            2    -10.5
#> 152      CTCF     ChIP            2    -93.5
#> 153      CTCF     ChIP            2    -11.5
#> 154      CTCF     ChIP            2     -4.5
#> 155      CTCF     ChIP            2     88.5
#> 156      CTCF     ChIP            2     -6.5
#> 157      CTCF     ChIP            2     11.5
#> 158      CTCF     ChIP            2      4.5
#> 159      CTCF     ChIP            2    104.5
#> 160      CTCF     ChIP            2    128.5
```
