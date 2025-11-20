# Get dataframe with motif enrichment values

Wrapper for \`MotifPeeker::motif_enrichment\` to get motif enrichment
counts and percentages for all peaks and motifs, generating a
`data.frame` suitable for plots. The `data.frame` contains values for
all and segregated peaks.

## Usage

``` r
get_df_enrichment(
  result,
  segregated_peaks,
  user_motifs,
  genome_build,
  reference_index = 1,
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

- segregated_peaks:

  A `list` object generated using
  [`segregate_seqs`](https://neurogenomics.github.io/MotifPeeker/reference/segregate_seqs.md).

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

- reference_index:

  An integer specifying the index of the peak file to use as the
  reference dataset for comparison. Indexing starts from 1. (default =
  1)

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

- group1:

  Segregated group- "all", "Common" or "Unique".

- group2:

  "reference" or "comparison" group.

- count_enriched:

  Number of peaks with motif.

- count_nonenriched:

  Number of peaks without motif.

- perc_enriched:

  Percentage of peaks with motif.

- perc_nonenriched:

  Percentage of peaks without motif.

## See also

Other generate data.frames:
[`get_df_distances()`](https://neurogenomics.github.io/MotifPeeker/reference/get_df_distances.md),
[`get_df_distances_bootstrapped()`](https://neurogenomics.github.io/MotifPeeker/reference/get_df_distances_bootstrapped.md)

## Examples

``` r
if (memes::meme_is_installed()) {
    data("CTCF_ChIP_peaks", package = "MotifPeeker")
    data("CTCF_TIP_peaks", package = "MotifPeeker")
    data("motif_MA1102.3", package = "MotifPeeker")
    data("motif_MA1930.2", package = "MotifPeeker")
    input <- list(
        peaks = list(CTCF_ChIP_peaks, CTCF_TIP_peaks),
        exp_type = c("ChIP", "TIP"),
        exp_labels = c("CTCF_ChIP", "CTCF_TIP"),
        read_count = c(150, 200),
        peak_count = c(100, 120)
    )
    segregated_input <- segregate_seqs(input$peaks[[1]], input$peaks[[2]])
    motifs <- list(
        motifs = list(motif_MA1930.2, motif_MA1102.3),
        motif_labels = list("MA1930.2", "MA1102.3")
    )
    reference_index <- 1

    if (requireNamespace("BSgenome.Hsapiens.UCSC.hg38")) {
        genome_build <-
            BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
    
        enrichment_df <- get_df_enrichment(
            input, segregated_input, motifs, genome_build,
            reference_index = 1
        )
    }
}
```
