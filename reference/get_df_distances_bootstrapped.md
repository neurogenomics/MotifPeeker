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
#>     exp_label exp_type motif_indice bootstrap_iteration  distance
#> 1        CTCF     ChIP            1                   1  16.00000
#> 2        CTCF     ChIP            1                   2   6.00000
#> 3        CTCF     ChIP            1                   3  13.50000
#> 4        CTCF     ChIP            1                   4  24.00000
#> 5        CTCF     ChIP            1                   5   5.00000
#> 6        CTCF     ChIP            1                   6  20.20000
#> 7        CTCF     ChIP            1                   7  16.66667
#> 8        CTCF     ChIP            1                   8  26.80000
#> 9        CTCF     ChIP            1                   9  23.00000
#> 10       CTCF     ChIP            1                  10  23.50000
#> 11       CTCF     ChIP            1                  11  16.66667
#> 12       CTCF     ChIP            1                  12  16.00000
#> 13       CTCF     ChIP            1                  13   6.00000
#> 14       CTCF     ChIP            1                  14  20.40000
#> 15       CTCF     ChIP            1                  15  19.33333
#> 16       CTCF     ChIP            1                  16  20.33333
#> 17       CTCF     ChIP            1                  17  25.20000
#> 18       CTCF     ChIP            1                  18  23.20000
#> 19       CTCF     ChIP            1                  19  18.57143
#> 20       CTCF     ChIP            1                  20  32.25000
#> 21       CTCF     ChIP            1                  21  20.16667
#> 22       CTCF     ChIP            1                  22  20.60000
#> 23       CTCF     ChIP            1                  23  16.25000
#> 24       CTCF     ChIP            1                  24  27.00000
#> 25       CTCF     ChIP            1                  25  25.57143
#> 26       CTCF     ChIP            1                  26  19.75000
#> 27       CTCF     ChIP            1                  27  24.00000
#> 28       CTCF     ChIP            1                  28  25.50000
#> 29       CTCF     ChIP            1                  29  19.75000
#> 30       CTCF     ChIP            1                  30  16.66667
#> 31       CTCF     ChIP            1                  31  14.80000
#> 32       CTCF     ChIP            1                  32  20.16667
#> 33       CTCF     ChIP            1                  33  22.00000
#> 34       CTCF     ChIP            1                  34  18.16667
#> 35       CTCF     ChIP            1                  35  16.50000
#> 36       CTCF     ChIP            1                  36  18.16667
#> 37       CTCF     ChIP            1                  37  10.66667
#> 38       CTCF     ChIP            1                  38  19.25000
#> 39       CTCF     ChIP            1                  39  13.75000
#> 40       CTCF     ChIP            1                  40  20.20000
#> 41       CTCF     ChIP            1                  41  22.60000
#> 42       CTCF     ChIP            1                  42  21.71429
#> 43       CTCF     ChIP            1                  43  20.00000
#> 44       CTCF     ChIP            1                  44  24.33333
#> 45       CTCF     ChIP            1                  45  23.33333
#> 46       CTCF     ChIP            1                  46  24.33333
#> 47       CTCF     ChIP            1                  47  15.20000
#> 48       CTCF     ChIP            1                  48  20.33333
#> 49       CTCF     ChIP            1                  49  20.00000
#> 50       CTCF     ChIP            1                  50  11.00000
#> 51       CTCF     ChIP            1                  51  27.00000
#> 52       CTCF     ChIP            1                  52  21.83333
#> 53       CTCF     ChIP            1                  53  19.33333
#> 54       CTCF     ChIP            1                  54  26.50000
#> 55       CTCF     ChIP            1                  55  20.16667
#> 56       CTCF     ChIP            1                  56  17.00000
#> 57       CTCF     ChIP            1                  57   6.00000
#> 58       CTCF     ChIP            1                  58  23.50000
#> 59       CTCF     ChIP            1                  59  28.66667
#> 60       CTCF     ChIP            1                  60  16.66667
#> 61       CTCF     ChIP            1                  61  17.25000
#> 62       CTCF     ChIP            1                  62  20.20000
#> 63       CTCF     ChIP            1                  63  20.33333
#> 64       CTCF     ChIP            1                  64  25.20000
#> 65       CTCF     ChIP            1                  65  22.50000
#> 66       CTCF     ChIP            1                  66  22.60000
#> 67       CTCF     ChIP            1                  67  22.00000
#> 68       CTCF     ChIP            1                  68  21.50000
#> 69       CTCF     ChIP            1                  69  10.33333
#> 70       CTCF     ChIP            1                  70   7.50000
#> 71       CTCF     ChIP            1                  71   6.00000
#> 72       CTCF     ChIP            1                  72  18.28571
#> 73       CTCF     ChIP            1                  73   6.00000
#> 74       CTCF     ChIP            1                  74   9.75000
#> 75       CTCF     ChIP            1                  75  28.66667
#> 76       CTCF     ChIP            1                  76  15.20000
#> 77       CTCF     ChIP            1                  77  15.40000
#> 78       CTCF     ChIP            1                  78  26.50000
#> 79       CTCF     ChIP            1                  79  30.66667
#> 80       CTCF     ChIP            1                  80  27.00000
#> 81       CTCF     ChIP            1                  81  16.25000
#> 82       CTCF     ChIP            1                  82  25.50000
#> 83       CTCF     ChIP            1                  83  13.50000
#> 84       CTCF     ChIP            1                  84  20.20000
#> 85       CTCF     ChIP            1                  85  14.00000
#> 86       CTCF     ChIP            1                  86  27.00000
#> 87       CTCF     ChIP            1                  87  17.25000
#> 88       CTCF     ChIP            1                  88  20.80000
#> 89       CTCF     ChIP            1                  89  18.00000
#> 90       CTCF     ChIP            1                  90  19.66667
#> 91       CTCF     ChIP            1                  91  17.25000
#> 92       CTCF     ChIP            1                  92  27.00000
#> 93       CTCF     ChIP            1                  93  19.25000
#> 94       CTCF     ChIP            1                  94  27.00000
#> 95       CTCF     ChIP            1                  95  19.66667
#> 96       CTCF     ChIP            1                  96  27.66667
#> 97       CTCF     ChIP            1                  97  15.20000
#> 98       CTCF     ChIP            1                  98  15.20000
#> 99       CTCF     ChIP            1                  99  24.16667
#> 100      CTCF     ChIP            1                 100  25.20000
#> 101      CTCF     ChIP            2                   1  70.16667
#> 102      CTCF     ChIP            2                   2  11.50000
#> 103      CTCF     ChIP            2                   3  14.00000
#> 104      CTCF     ChIP            2                   4  16.50000
#> 105      CTCF     ChIP            2                   5  71.83333
#> 106      CTCF     ChIP            2                   6  99.50000
#> 107      CTCF     ChIP            2                   7 126.50000
#> 108      CTCF     ChIP            2                   8 126.50000
#> 109      CTCF     ChIP            2                   9  71.50000
#> 110      CTCF     ChIP            2                  10  71.50000
#> 111      CTCF     ChIP            2                  11  99.50000
#> 112      CTCF     ChIP            2                  12  44.50000
#> 113      CTCF     ChIP            2                  13  42.00000
#> 114      CTCF     ChIP            2                  14  70.16667
#> 115      CTCF     ChIP            2                  15  72.50000
#> 116      CTCF     ChIP            2                  16  16.50000
#> 117      CTCF     ChIP            2                  17  16.50000
#> 118      CTCF     ChIP            2                  18  14.00000
#> 119      CTCF     ChIP            2                  19        NA
#> 120      CTCF     ChIP            2                  20 126.50000
#> 121      CTCF     ChIP            2                  21  14.00000
#> 122      CTCF     ChIP            2                  22 126.50000
#> 123      CTCF     ChIP            2                  23  69.00000
#> 124      CTCF     ChIP            2                  24        NA
#> 125      CTCF     ChIP            2                  25  16.50000
#> 126      CTCF     ChIP            2                  26  16.50000
#> 127      CTCF     ChIP            2                  27  71.50000
#> 128      CTCF     ChIP            2                  28        NA
#> 129      CTCF     ChIP            2                  29  11.50000
#> 130      CTCF     ChIP            2                  30  16.50000
#> 131      CTCF     ChIP            2                  31  11.50000
#> 132      CTCF     ChIP            2                  32  51.50000
#> 133      CTCF     ChIP            2                  33  77.50000
#> 134      CTCF     ChIP            2                  34  70.16667
#> 135      CTCF     ChIP            2                  35  42.00000
#> 136      CTCF     ChIP            2                  36  33.50000
#> 137      CTCF     ChIP            2                  37  71.83333
#> 138      CTCF     ChIP            2                  38  14.00000
#> 139      CTCF     ChIP            2                  39        NA
#> 140      CTCF     ChIP            2                  40  14.00000
#> 141      CTCF     ChIP            2                  41  72.50000
#> 142      CTCF     ChIP            2                  42  71.50000
#> 143      CTCF     ChIP            2                  43 126.50000
#> 144      CTCF     ChIP            2                  44  11.50000
#> 145      CTCF     ChIP            2                  45 126.50000
#> 146      CTCF     ChIP            2                  46  16.50000
#> 147      CTCF     ChIP            2                  47  42.00000
#> 148      CTCF     ChIP            2                  48  71.50000
#> 149      CTCF     ChIP            2                  49  71.50000
#> 150      CTCF     ChIP            2                  50        NA
#> 151      CTCF     ChIP            2                  51  16.50000
#> 152      CTCF     ChIP            2                  52  14.00000
#> 153      CTCF     ChIP            2                  53  71.50000
#> 154      CTCF     ChIP            2                  54  16.50000
#> 155      CTCF     ChIP            2                  55        NA
#> 156      CTCF     ChIP            2                  56  71.50000
#> 157      CTCF     ChIP            2                  57 126.50000
#> 158      CTCF     ChIP            2                  58  16.50000
#> 159      CTCF     ChIP            2                  59  71.83333
#> 160      CTCF     ChIP            2                  60   8.50000
#> 161      CTCF     ChIP            2                  61  33.50000
#> 162      CTCF     ChIP            2                  62        NA
#> 163      CTCF     ChIP            2                  63   8.50000
#> 164      CTCF     ChIP            2                  64        NA
#> 165      CTCF     ChIP            2                  65  16.50000
#> 166      CTCF     ChIP            2                  66        NA
#> 167      CTCF     ChIP            2                  67  44.50000
#> 168      CTCF     ChIP            2                  68 126.50000
#> 169      CTCF     ChIP            2                  69  71.50000
#> 170      CTCF     ChIP            2                  70  99.50000
#> 171      CTCF     ChIP            2                  71        NA
#> 172      CTCF     ChIP            2                  72 126.50000
#> 173      CTCF     ChIP            2                  73  16.50000
#> 174      CTCF     ChIP            2                  74        NA
#> 175      CTCF     ChIP            2                  75  66.00000
#> 176      CTCF     ChIP            2                  76  16.50000
#> 177      CTCF     ChIP            2                  77  70.16667
#> 178      CTCF     ChIP            2                  78  56.75000
#> 179      CTCF     ChIP            2                  79  70.16667
#> 180      CTCF     ChIP            2                  80  99.50000
#> 181      CTCF     ChIP            2                  81  71.50000
#> 182      CTCF     ChIP            2                  82  16.50000
#> 183      CTCF     ChIP            2                  83  16.50000
#> 184      CTCF     ChIP            2                  84  71.50000
#> 185      CTCF     ChIP            2                  85  44.50000
#> 186      CTCF     ChIP            2                  86  14.00000
#> 187      CTCF     ChIP            2                  87  71.50000
#> 188      CTCF     ChIP            2                  88        NA
#> 189      CTCF     ChIP            2                  89  72.50000
#> 190      CTCF     ChIP            2                  90  71.50000
#> 191      CTCF     ChIP            2                  91 126.50000
#> 192      CTCF     ChIP            2                  92  71.50000
#> 193      CTCF     ChIP            2                  93  14.00000
#> 194      CTCF     ChIP            2                  94  16.50000
#> 195      CTCF     ChIP            2                  95        NA
#> 196      CTCF     ChIP            2                  96  16.50000
#> 197      CTCF     ChIP            2                  97  71.50000
#> 198      CTCF     ChIP            2                  98  16.75000
#> 199      CTCF     ChIP            2                  99  16.50000
#> 200      CTCF     ChIP            2                 100  71.83333
```
