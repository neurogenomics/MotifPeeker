# Find similar motifs

Search through provided motif database to find similar motifs to the
input. Light wrapper around `TOMTOM` from MEME Suite.

## Usage

``` r
find_motifs(
  streme_out,
  motif_db,
  out_dir = tempdir(),
  meme_path = NULL,
  BPPARAM = BiocParallel::bpparam(),
  verbose = FALSE,
  debug = FALSE,
  ...
)
```

## Arguments

- streme_out:

  Output from
  [`denovo_motifs`](https://neurogenomics.github.io/MotifPeeker/reference/denovo_motifs.md).

- motif_db:

  Path to `.meme` format file to use as reference database, or a list of
  [`universalmotif-class`](https://rdrr.io/pkg/universalmotif/man/universalmotif-class.html)
  objects. (optional) Results from de-novo motif discovery are searched
  against this database to find similar motifs. If not provided, JASPAR
  CORE database will be used. **NOTE**: p-value estimates are inaccurate
  when the database has fewer than 50 entries.

- out_dir:

  A `character` vector of output directory to save STREME results to.
  (default = [`tempdir()`](https://rdrr.io/r/base/tempfile.html))

- meme_path:

  path to "meme/bin/" (default: `NULL`). Will use default search
  behavior as described in `check_meme_install()` if unset.

- BPPARAM:

  A
  [`BiocParallelParam-class`](https://rdrr.io/pkg/BiocParallel/man/BiocParallelParam-class.html)
  object specifying run parameters. (default = bpparam())

- verbose:

  A logical indicating whether to print verbose messages while running
  the function. (default = FALSE)

- debug:

  A logical indicating whether to print debug messages while running the
  function. (default = FALSE)

- ...:

  Additional arguments to pass to `TOMTOM`. For more information, refer
  to the official MEME Suite documentation on
  [TOMTOM](https://meme-suite.org/meme/doc/tomtom.html).

## Value

data.frame of match results. Contains `best_match_motif` column of
`universalmotif` objects with the matched PWM from the database, a
series of `best_match_*` columns describing the TomTom results of the
match, and a `tomtom` list column storing the ranked list of possible
matches to each motif. If a universalmotif data.frame is used as input,
these columns are appended to the data.frame. If no matches are
returned, `tomtom` and `best_match_motif` columns will be set to `NA`
and a message indicating this will print.

## Examples

``` r
if (memes::meme_is_installed()) {
    data("CTCF_TIP_peaks", package = "MotifPeeker")
    
    if (requireNamespace("BSgenome.Hsapiens.UCSC.hg38", quietly = TRUE)) {
        genome_build <-
            BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
   
        res <- denovo_motifs(list(CTCF_TIP_peaks),
                        trim_seq_width = 50,
                        genome_build = genome_build,
                        discover_motifs_count = 1,
                        filter_n = 10,
                        out_dir = tempdir())
        res2 <- find_motifs(res, motif_db = get_JASPARCORE(),
                            out_dir = tempdir())
        print(res2)
    }
}
#> Warning: p-values will be inaccurate if primary and control
#> Warning: p-values will be inaccurate if primary and control
#> [[1]]
#> [[1]][[1]]
#>          motif           name  altname  consensus alphabet strand  icscore
#> 1 <mot:m01_..> m01_TCCCAGCACD STREME-1 TCCCAKMACN      DNA     +- 11.51542
#>   nsites pval type pseudocount          bkg X.name. X.altname. best_match_name
#> 1     21    1  PCM           0 0.24, 0.....    name    altname        MA2125.1
#>   best_match_altname                                             best_db_name
#> 1             Zfp809 1be0525e9d0c_JASPAR2024_CORE_non-redundant_pfms_meme.txt
#>   best_match_offset best_match_pval best_match_eval best_match_qval
#> 1                 1         3.6e-05          0.0845           0.169
#>   best_match_strand best_match_motif       tomtom
#> 1                 +     <mot:MA21..> c("MA212....
#> 
#> [Hidden empty columns: family, organism, bkgsites, qval, eval.]
#> 
#> 
```
