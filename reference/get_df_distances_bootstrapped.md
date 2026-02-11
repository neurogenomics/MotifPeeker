# Get dataframe with bootstrapped motif-summit distances

Wrapper for \`MotifPeeker::bootstrap_distances\` to get bootstrapped
motif-summit distances for given peaks and motifs, generating a
`data.frame` suitable for plots.

## Usage

``` r
get_df_distances_bootstrapped(
  result,
  user_motifs,
  genome_build,
  samples_n = NULL,
  samples_len = NULL,
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

- samples_n:

  An integer specifying the number of bootstrap samples to generate. If
  `NULL`, it is set to 70% of the number of peaks.

- samples_len:

  An integer specifying the number of peaks to sample in each bootstrap
  iteration. If `NULL`, it is set to 20 peaks.

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

- bootstrap_iteration:

  Bootstrap iteration number.

- distance:

  Mean of absolute distances between peak summit and motif.

## See also

Other generate data.frames:
[`get_df_distances()`](https://neurogenomics.github.io/MotifPeeker/reference/get_df_distances.md),
[`get_df_enrichment()`](https://neurogenomics.github.io/MotifPeeker/reference/get_df_enrichment.md)

## Examples

``` r
if (memes::meme_is_installed()) {
    peak <- system.file("extdata", "CTCF_ChIP_peaks.narrowPeak",
                package = "MotifPeeker") |>
                read_peak_file() |>
                sample(20)
    motif_MA1102.3 <- system.file("extdata", "motif_MA1102.3.jaspar",
                package = "MotifPeeker") |> read_motif_file()
    motif_MA1930.2 <- system.file("extdata", "motif_MA1930.2.jaspar",
                package = "MotifPeeker") |> read_motif_file()

    input <- list(
        peaks = peak,
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
        genome_build <-
            BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
            
        distances_df_bootstrapped <- get_df_distances_bootstrapped(
            input,
            user_motifs = motifs,
            genome_build = genome_build,
            samples_n = NULL,
            samples_len = NULL,
            verbose = FALSE
        )
        print(distances_df_bootstrapped)
    }
}
#>     exp_label exp_type motif_indice bootstrap_iteration   distance
#> 1        CTCF     ChIP            1                   1  16.800000
#> 2        CTCF     ChIP            1                   2  27.000000
#> 3        CTCF     ChIP            1                   3  25.200000
#> 4        CTCF     ChIP            1                   4  21.500000
#> 5        CTCF     ChIP            1                   5  14.500000
#> 6        CTCF     ChIP            1                   6   6.000000
#> 7        CTCF     ChIP            1                   7  13.500000
#> 8        CTCF     ChIP            1                   8  12.714286
#> 9        CTCF     ChIP            1                   9  20.500000
#> 10       CTCF     ChIP            1                  10   7.000000
#> 11       CTCF     ChIP            1                  11  10.666667
#> 12       CTCF     ChIP            1                  12  21.400000
#> 13       CTCF     ChIP            1                  13  15.200000
#> 14       CTCF     ChIP            1                  14   6.000000
#> 15       CTCF     ChIP            1                  15  20.800000
#> 16       CTCF     ChIP            1                  16  23.200000
#> 17       CTCF     ChIP            1                  17  20.166667
#> 18       CTCF     ChIP            1                  18  23.500000
#> 19       CTCF     ChIP            1                  19  10.666667
#> 20       CTCF     ChIP            1                  20  13.000000
#> 21       CTCF     ChIP            1                  21  20.000000
#> 22       CTCF     ChIP            1                  22  26.800000
#> 23       CTCF     ChIP            1                  23  15.200000
#> 24       CTCF     ChIP            1                  24  17.250000
#> 25       CTCF     ChIP            1                  25  20.000000
#> 26       CTCF     ChIP            1                  26  16.750000
#> 27       CTCF     ChIP            1                  27  18.142857
#> 28       CTCF     ChIP            1                  28  13.666667
#> 29       CTCF     ChIP            1                  29  38.000000
#> 30       CTCF     ChIP            1                  30  12.600000
#> 31       CTCF     ChIP            1                  31  24.166667
#> 32       CTCF     ChIP            1                  32  15.000000
#> 33       CTCF     ChIP            1                  33  24.000000
#> 34       CTCF     ChIP            1                  34  18.000000
#> 35       CTCF     ChIP            1                  35  19.000000
#> 36       CTCF     ChIP            1                  36  19.250000
#> 37       CTCF     ChIP            1                  37  16.800000
#> 38       CTCF     ChIP            1                  38   7.000000
#> 39       CTCF     ChIP            1                  39  24.000000
#> 40       CTCF     ChIP            1                  40  24.166667
#> 41       CTCF     ChIP            1                  41  18.000000
#> 42       CTCF     ChIP            1                  42  15.000000
#> 43       CTCF     ChIP            1                  43  21.833333
#> 44       CTCF     ChIP            1                  44  23.000000
#> 45       CTCF     ChIP            1                  45  13.000000
#> 46       CTCF     ChIP            1                  46   7.000000
#> 47       CTCF     ChIP            1                  47  20.000000
#> 48       CTCF     ChIP            1                  48  10.250000
#> 49       CTCF     ChIP            1                  49  15.200000
#> 50       CTCF     ChIP            1                  50  20.166667
#> 51       CTCF     ChIP            1                  51  22.500000
#> 52       CTCF     ChIP            1                  52  23.333333
#> 53       CTCF     ChIP            1                  53  13.750000
#> 54       CTCF     ChIP            1                  54  23.000000
#> 55       CTCF     ChIP            1                  55  20.200000
#> 56       CTCF     ChIP            1                  56  19.333333
#> 57       CTCF     ChIP            1                  57   9.750000
#> 58       CTCF     ChIP            1                  58   6.666667
#> 59       CTCF     ChIP            1                  59  28.333333
#> 60       CTCF     ChIP            1                  60  13.000000
#> 61       CTCF     ChIP            1                  61  14.600000
#> 62       CTCF     ChIP            1                  62  21.428571
#> 63       CTCF     ChIP            1                  63  24.800000
#> 64       CTCF     ChIP            1                  64  24.000000
#> 65       CTCF     ChIP            1                  65  25.200000
#> 66       CTCF     ChIP            1                  66  24.000000
#> 67       CTCF     ChIP            1                  67  28.333333
#> 68       CTCF     ChIP            1                  68  25.500000
#> 69       CTCF     ChIP            1                  69  14.000000
#> 70       CTCF     ChIP            1                  70  13.000000
#> 71       CTCF     ChIP            1                  71  16.666667
#> 72       CTCF     ChIP            1                  72  13.750000
#> 73       CTCF     ChIP            1                  73  25.571429
#> 74       CTCF     ChIP            1                  74   9.500000
#> 75       CTCF     ChIP            1                  75  24.166667
#> 76       CTCF     ChIP            1                  76  16.500000
#> 77       CTCF     ChIP            1                  77  13.750000
#> 78       CTCF     ChIP            1                  78  19.625000
#> 79       CTCF     ChIP            1                  79  13.750000
#> 80       CTCF     ChIP            1                  80  28.333333
#> 81       CTCF     ChIP            1                  81  20.333333
#> 82       CTCF     ChIP            1                  82  25.500000
#> 83       CTCF     ChIP            1                  83  19.750000
#> 84       CTCF     ChIP            1                  84  19.250000
#> 85       CTCF     ChIP            1                  85  14.000000
#> 86       CTCF     ChIP            1                  86  20.000000
#> 87       CTCF     ChIP            1                  87   6.000000
#> 88       CTCF     ChIP            1                  88  16.666667
#> 89       CTCF     ChIP            1                  89  26.500000
#> 90       CTCF     ChIP            1                  90  19.333333
#> 91       CTCF     ChIP            1                  91  25.200000
#> 92       CTCF     ChIP            1                  92  20.600000
#> 93       CTCF     ChIP            1                  93   6.333333
#> 94       CTCF     ChIP            1                  94  27.000000
#> 95       CTCF     ChIP            1                  95  20.000000
#> 96       CTCF     ChIP            1                  96  20.000000
#> 97       CTCF     ChIP            1                  97  19.000000
#> 98       CTCF     ChIP            1                  98  12.000000
#> 99       CTCF     ChIP            1                  99  25.200000
#> 100      CTCF     ChIP            1                 100  22.500000
#> 101      CTCF     ChIP            2                   1  16.500000
#> 102      CTCF     ChIP            2                   2 126.500000
#> 103      CTCF     ChIP            2                   3 126.500000
#> 104      CTCF     ChIP            2                   4 126.500000
#> 105      CTCF     ChIP            2                   5  99.500000
#> 106      CTCF     ChIP            2                   6  16.500000
#> 107      CTCF     ChIP            2                   7  70.166667
#> 108      CTCF     ChIP            2                   8  16.500000
#> 109      CTCF     ChIP            2                   9 126.500000
#> 110      CTCF     ChIP            2                  10  16.500000
#> 111      CTCF     ChIP            2                  11 126.500000
#> 112      CTCF     ChIP            2                  12  99.500000
#> 113      CTCF     ChIP            2                  13         NA
#> 114      CTCF     ChIP            2                  14  16.500000
#> 115      CTCF     ChIP            2                  15         NA
#> 116      CTCF     ChIP            2                  16  70.166667
#> 117      CTCF     ChIP            2                  17         NA
#> 118      CTCF     ChIP            2                  18         NA
#> 119      CTCF     ChIP            2                  19  25.000000
#> 120      CTCF     ChIP            2                  20         NA
#> 121      CTCF     ChIP            2                  21  16.500000
#> 122      CTCF     ChIP            2                  22  71.500000
#> 123      CTCF     ChIP            2                  23  58.833333
#> 124      CTCF     ChIP            2                  24  44.500000
#> 125      CTCF     ChIP            2                  25  11.500000
#> 126      CTCF     ChIP            2                  26  71.500000
#> 127      CTCF     ChIP            2                  27  14.000000
#> 128      CTCF     ChIP            2                  28  16.500000
#> 129      CTCF     ChIP            2                  29 126.500000
#> 130      CTCF     ChIP            2                  30  14.000000
#> 131      CTCF     ChIP            2                  31  71.500000
#> 132      CTCF     ChIP            2                  32  33.500000
#> 133      CTCF     ChIP            2                  33  51.500000
#> 134      CTCF     ChIP            2                  34  16.500000
#> 135      CTCF     ChIP            2                  35  16.500000
#> 136      CTCF     ChIP            2                  36         NA
#> 137      CTCF     ChIP            2                  37  51.500000
#> 138      CTCF     ChIP            2                  38 126.500000
#> 139      CTCF     ChIP            2                  39 126.500000
#> 140      CTCF     ChIP            2                  40  71.500000
#> 141      CTCF     ChIP            2                  41  33.500000
#> 142      CTCF     ChIP            2                  42  56.750000
#> 143      CTCF     ChIP            2                  43  37.166667
#> 144      CTCF     ChIP            2                  44  71.833333
#> 145      CTCF     ChIP            2                  45 126.500000
#> 146      CTCF     ChIP            2                  46  16.500000
#> 147      CTCF     ChIP            2                  47  16.500000
#> 148      CTCF     ChIP            2                  48  16.500000
#> 149      CTCF     ChIP            2                  49  70.166667
#> 150      CTCF     ChIP            2                  50  71.500000
#> 151      CTCF     ChIP            2                  51  72.500000
#> 152      CTCF     ChIP            2                  52  53.000000
#> 153      CTCF     ChIP            2                  53  71.500000
#> 154      CTCF     ChIP            2                  54  71.500000
#> 155      CTCF     ChIP            2                  55         NA
#> 156      CTCF     ChIP            2                  56  16.500000
#> 157      CTCF     ChIP            2                  57         NA
#> 158      CTCF     ChIP            2                  58         NA
#> 159      CTCF     ChIP            2                  59  14.000000
#> 160      CTCF     ChIP            2                  60 126.500000
#> 161      CTCF     ChIP            2                  61  33.500000
#> 162      CTCF     ChIP            2                  62  99.500000
#> 163      CTCF     ChIP            2                  63  42.000000
#> 164      CTCF     ChIP            2                  64         NA
#> 165      CTCF     ChIP            2                  65  11.166667
#> 166      CTCF     ChIP            2                  66         NA
#> 167      CTCF     ChIP            2                  67  71.500000
#> 168      CTCF     ChIP            2                  68  44.500000
#> 169      CTCF     ChIP            2                  69 126.500000
#> 170      CTCF     ChIP            2                  70  16.500000
#> 171      CTCF     ChIP            2                  71  16.500000
#> 172      CTCF     ChIP            2                  72  53.000000
#> 173      CTCF     ChIP            2                  73  71.500000
#> 174      CTCF     ChIP            2                  74         NA
#> 175      CTCF     ChIP            2                  75  16.500000
#> 176      CTCF     ChIP            2                  76  71.500000
#> 177      CTCF     ChIP            2                  77  11.166667
#> 178      CTCF     ChIP            2                  78 126.500000
#> 179      CTCF     ChIP            2                  79         NA
#> 180      CTCF     ChIP            2                  80         NA
#> 181      CTCF     ChIP            2                  81   5.500000
#> 182      CTCF     ChIP            2                  82  16.500000
#> 183      CTCF     ChIP            2                  83         NA
#> 184      CTCF     ChIP            2                  84  56.750000
#> 185      CTCF     ChIP            2                  85         NA
#> 186      CTCF     ChIP            2                  86  80.000000
#> 187      CTCF     ChIP            2                  87 126.500000
#> 188      CTCF     ChIP            2                  88 126.500000
#> 189      CTCF     ChIP            2                  89  99.500000
#> 190      CTCF     ChIP            2                  90         NA
#> 191      CTCF     ChIP            2                  91  71.500000
#> 192      CTCF     ChIP            2                  92  16.500000
#> 193      CTCF     ChIP            2                  93  69.000000
#> 194      CTCF     ChIP            2                  94         NA
#> 195      CTCF     ChIP            2                  95  16.500000
#> 196      CTCF     ChIP            2                  96  16.500000
#> 197      CTCF     ChIP            2                  97  71.500000
#> 198      CTCF     ChIP            2                  98  71.500000
#> 199      CTCF     ChIP            2                  99 126.500000
#> 200      CTCF     ChIP            2                 100         NA
```
