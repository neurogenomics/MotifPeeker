# Changelog

## MotifPeeker 1.3.1

### Section Rework

- Motif-summit distances
  - Remove distances by peak count.
  - Reword descriptions
  - \[NEW\] Add bootstrapping to visualise the distribution of
    motif-summit distances.

### New Features

- Add support for directly importing “mm10” and “mm39” mouse genome
  builds.
- `read_motif_file` can now accept an `universalmotif` object, returns
  the same object.
- Input datasets section now reports datasets in a tabular form.

### Documentation

- Improve instructions for importing genome builds.
- Improve instructions for importing motifs.

## MotifPeeker 1.1.3

### Miscellaneous

- Changed import to use `Seqinfo` instead of `GenomeInfoDb`.

## MotifPeeker 1.1.2

### Miscellaneous

- Only consider unique peaks in peak count.
- Only return unique peaks in
  [`segregate_seqs()`](https://neurogenomics.github.io/MotifPeeker/reference/segregate_seqs.md).

### Bug Fixes

- Sanitise peak input names before running FIMO.

## MotifPeeker 1.1.1

### Bug Fixes

- Fix importing MACS peak files with no peak names.
- Update tests for
  [`messager()`](https://neurogenomics.github.io/MotifPeeker/reference/messager.md).

### Miscellaneous

- Add citation to pre-print.
- Switch to the official repo for rworkflows.

## MotifPeeker 0.99.13

### Bug Fixes

- Fix missing second table in known motif enrichment analysis tabs.

### Miscellaneous

- Add “in Bioc” badge to README.

## MotifPeeker 0.99.12

### Bug Fixes

- Supply `meme_path` and `verbose` to second `motif_enrichment` call in
  `get_df_enrichment`.

### Miscellaneous

- Update example reports.
- Add new author.
- Add BioConductor installation instructions to README.

## MotifPeeker 0.99.11

### Miscellaneous

- Correct “de-novo motif discovery” term to “motif discovery”. STREME
  does not perform de-novo motif discovery.
- Add package version to report header.

## MotifPeeker 0.99.9 / 0.99.10

### Bug Fixes

- Fix
  [`download_button()`](https://neurogenomics.github.io/MotifPeeker/reference/download_button.md)
  error when `downloadthis` package is not available.

## MotifPeeker 0.99.8

### Miscellaneous

- Optimise examples and remove `\donttest{}` blocks.
- Add GitHub Actions for rworkflows without MEME Suite.

## MotifPeeker 0.99.7

### New Features

- Replace `workers` argument with `BPPARAM`. Give users more control
  over the BiocParallel implementation.

### Miscellaneous

- Remove [`cat()`](https://rdrr.io/r/base/cat.html) calls in functions.
- Implement helper
  [`check_input()`](https://neurogenomics.github.io/MotifPeeker/reference/check_input.md)
  to validate input before passing them to other functions.
- Run examples and tests only if MEME Suite is detected (only for
  functions which require MEME Suite).

## MotifPeeker 0.99.5 / 0.99.6

### Miscellaneous

- Replace `magrittr` import by `dplyr::%>%`.
- Reduce the number of exported functions.
- Move utility functions to ‘utilities.R’.
- Allow vignettes to run without MEME suite installed.
- Remove `stopper()` wrapper around
  [`stop()`](https://rdrr.io/r/base/stop.html).
- Use message() for parallel executions

## MotifPeeker 0.99.4

### Miscellaneous

- Switch to a smaller file to download in `check_ENCODE` example.
- Move some code outside `\donttest{}` to prevent `BiocCheck()` error
  about missing examples.

## MotifPeeker 0.99.3

### Miscellaneous

- Wrap certain examples under `\donttest{}` to reduce R CMD CHECK
  runtime.
- \[GitHub\] Add `CODECOV_TOKEN` secret to `rworkflows`.
- Skip running tests which require download if offline.

## MotifPeeker 0.99.2

### Miscellaneous

- Substitute [`system()`](https://rdrr.io/r/base/system.html) with
  [`system2()`](https://rdrr.io/r/base/system2.html).
- Reduce `denovo_motifs` in examples and tests to reduce R CMD CHECK
  runtime.
- Add `.BBSoptions` to `.Rbuildignore`.

## MotifPeeker 0.99.1

### Miscellaneous

- `.BBSoptions` added to skip Windows builders on Bioconductor.

## MotifPeeker 0.99.0

### New features

- `MotifPeeker` submitted to Bioconductor.
