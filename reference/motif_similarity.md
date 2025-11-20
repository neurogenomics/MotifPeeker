# Compare motifs from segregated sequences

Compute motif similarity scores between motifs discovered from
segregated sequences. Wrapper around
[`compare_motifs`](https://rdrr.io/pkg/universalmotif/man/compare_motifs.html)
to compare motifs from different groups of sequences. To see the
possible similarity measures available, refer to details.

## Usage

``` r
motif_similarity(
  streme_out,
  method = "PCC",
  normalise.scores = TRUE,
  BPPARAM = BiocParallel::bpparam(),
  ...
)
```

## Arguments

- streme_out:

  Output from
  [`denovo_motifs`](https://neurogenomics.github.io/MotifPeeker/reference/denovo_motifs.md).

- method:

  `character(1)` One of PCC, EUCL, SW, KL, ALLR, BHAT, HELL, SEUCL, MAN,
  ALLR_LL, WEUCL, WPCC. See details.

- normalise.scores:

  `logical(1)` Favour alignments which leave fewer unaligned positions,
  as well as alignments between motifs of similar length. Similarity
  scores are multiplied by the ratio of aligned positions to the total
  number of positions in the larger motif, and the inverse for distance
  scores.

- BPPARAM:

  A
  [`BiocParallelParam-class`](https://rdrr.io/pkg/BiocParallel/man/BiocParallelParam-class.html)
  object specifying run parameters. (default = bpparam())

- ...:

  Arguments passed on to
  [`universalmotif::compare_motifs`](https://rdrr.io/pkg/universalmotif/man/compare_motifs.html)

  `motifs`

  :   See
      [`convert_motifs()`](https://rdrr.io/pkg/universalmotif/man/convert_motifs.html)
      for acceptable motif formats.

  `compare.to`

  :   `numeric` If missing, compares all motifs to all other motifs.
      Otherwise compares all motifs to the specified motif(s).

  `db.scores`

  :   `data.frame` or `DataFrame`. See `details`.

  `use.freq`

  :   `numeric(1)`. For comparing the `multifreq` slot.

  `use.type`

  :   `character(1)` One of `'PPM'` and `'ICM'`. The latter allows for
      taking into account the background frequencies if
      `relative_entropy = TRUE`. Note that `'ICM'` is not allowed when
      `method = c("ALLR", "ALLR_LL")`.

  `tryRC`

  :   `logical(1)` Try the reverse complement of the motifs as well,
      report the best score.

  `min.overlap`

  :   `numeric(1)` Minimum overlap required when aligning the motifs.
      Setting this to a number higher then the width of the motifs will
      not allow any overhangs. Can also be a number between 0 and 1,
      representing the minimum fraction that the motifs must overlap.

  `min.mean.ic`

  :   `numeric(1)` Minimum mean information content between the two
      motifs for an alignment to be scored. This helps prevent scoring
      alignments between low information content regions of two motifs.
      Note that this can result in some comparisons failing if no
      alignment passes the mean IC threshold. Use
      [`average_ic()`](https://rdrr.io/pkg/universalmotif/man/utils-motif.html)
      to filter out low IC motifs to get around this if you want to
      avoid getting `NA`s in your output.

  `min.position.ic`

  :   `numeric(1)` Minimum information content required between
      individual alignment positions for it to be counted in the final
      alignment score. It is recommended to use this together with
      `normalise.scores = TRUE`, as this will help punish scores
      resulting from only a fraction of an alignment.

  `relative_entropy`

  :   `logical(1)` Change the ICM calculation affecting
      `min.position.ic` and `min.mean.ic`. See
      [`convert_type()`](https://rdrr.io/pkg/universalmotif/man/convert_type.html).

  `max.p`

  :   `numeric(1)` Maximum P-value allowed in reporting matches. Only
      used if `compare.to` is set.

  `max.e`

  :   `numeric(1)` Maximum E-value allowed in reporting matches. Only
      used if `compare.to` is set. The E-value is the P-value multiplied
      by the number of input motifs times two.

  `nthreads`

  :   `numeric(1)` Run
      [`compare_motifs()`](https://rdrr.io/pkg/universalmotif/man/compare_motifs.html)
      in parallel with `nthreads` threads. `nthreads = 0` uses all
      available threads.

  `score.strat`

  :   `character(1)` How to handle column scores calculated from motif
      alignments. "sum": add up all scores. "a.mean": take the
      arithmetic mean. "g.mean": take the geometric mean. "median": take
      the median. "wa.mean", "wg.mean": weighted arithmetic/geometric
      mean. "fzt": Fisher Z-transform. Weights are the total information
      content shared between aligned columns.

  `output.report`

  :   `character(1)` Provide a filename for
      [`compare_motifs()`](https://rdrr.io/pkg/universalmotif/man/compare_motifs.html)
      to write an html ouput report to. The top matches are shown
      alongside figures of the match alignments. This requires the
      `knitr` and `rmarkdown` packages. (Note: still in development.)

  `output.report.max.print`

  :   `numeric(1)` Maximum number of top matches to print.

## Value

A list of matrices containing the similarity scores between motifs from
different groups of sequences. The order of comparison is as follows,
with first element representing the rows and second element representing
the columns of the matrix:

- 1\. **Common motifs comparison:** Common seqs from reference (1) \<-\>
  comparison (2)

- 2\. **Unique motifs comparison:** Unique seqs from reference (1) \<-\>
  comparison (2)

- 3\. **Cross motifs comparison 1:** Unique seqs from reference (1)
  \<-\> comparison (1)

- 4\. **Cross motifs comparison 2:** Unique seqs from comparison (2)
  \<-\> reference (1)

The list is repeated for each set of comparison groups in input.

## Details

### Available metrics

The following metrics are available:

- Euclidean distance (`EUCL`) (Choi et al. 2004)

- Weighted Euclidean distance (`WEUCL`)

- Kullback-Leibler divergence (`KL`) (Kullback and Leibler 1951; Roepcke
  et al. 2005)

- Hellinger distance (`HELL`) (Hellinger 1909)

- Squared Euclidean distance (`SEUCL`)

- Manhattan distance (`MAN`)

- Pearson correlation coefficient (`PCC`)

- Weighted Pearson correlation coefficient (`WPCC`)

- Sandelin-Wasserman similarity (`SW`), or sum of squared distances
  (Sandelin and Wasserman 2004)

- Average log-likelihood ratio (`ALLR`) (Wang and Stormo 2003)

- Lower limit ALLR (`ALLR_LL`) (Mahony et al. 2007)

- Bhattacharyya coefficient (`BHAT`) (Bhattacharyya 1943)

Comparisons are calculated between two motifs at a time. All possible
alignments are scored, and the best score is reported. In an alignment
scores are calculated individually between columns. How those scores are
combined to generate the final alignment scores depends on
`score.strat`.

See the "Motif comparisons and P-values" vignette for a description of
the various metrics. Note that `PCC`, `WPCC`, `SW`, `ALLR`, `ALLR_LL`
and `BHAT` are similarities; higher values mean more similar motifs. For
the remaining metrics, values closer to zero represent more similar
motifs.

Small pseudocounts are automatically added when one of the following
methods is used: `KL`, `ALLR`, `ALLR_LL`, `IS`. This is avoid zeros in
the calculations.

### Calculating P-values

To note regarding p-values: P-values are pre-computed using the
[`make_DBscores()`](https://rdrr.io/pkg/universalmotif/man/make_DBscores.html)
function. If not given, then uses a set of internal precomputed P-values
from the JASPAR2018 CORE motifs. These precalculated scores are
dependent on the length of the motifs being compared. This takes into
account that comparing small motifs with larger motifs leads to higher
scores, since the probability of finding a higher scoring alignment is
higher.

The default P-values have been precalculated for regular DNA motifs.
They are of little use for motifs with a different number of alphabet
letters (or even the `multifreq` slot).

## Examples

``` r
if (memes::meme_is_installed()) {
    data("CTCF_TIP_peaks", package = "MotifPeeker")
    data("CTCF_ChIP_peaks", package = "MotifPeeker")

    if (requireNamespace("BSgenome.Hsapiens.UCSC.hg38")) {
        genome_build <-
            BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
        segregated_peaks <- segregate_seqs(CTCF_TIP_peaks, CTCF_ChIP_peaks)
        denovo_motifs <- denovo_motifs(unlist(segregated_peaks),
                            trim_seq_width = 50,
                            genome_build = genome_build,
                            discover_motifs_count = 1,
                            filter_n = 6,
                            maxw = 8,
                            minw = 8,
                            out_dir = tempdir())
        similarity_matrices <- motif_similarity(denovo_motifs)
        print(similarity_matrices)
    }
}
#> [[1]]
#>                m01_YGCCCYCTRSTGGCMRV
#> m01_GAGGDSARAS             0.2258419
#> 
#> [[2]]
#>                   m01_CMYCTRSTGGYY
#> m01_TGASCTCHADWGW        0.4360961
#> 
#> [[3]]
#>                   m01_YGCCCYCTRSTGGCMRV
#> m01_TGASCTCHADWGW             0.4128632
#> 
#> [[4]]
#>                  m01_GAGGDSARAS
#> m01_CMYCTRSTGGYY      0.2843023
#> 
```
