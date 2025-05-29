# MotifPeeker 1.1.1

## Bug Fixes
* Fix importing MACS peak files with no peak names.
* Update tests for `messager()`.

## Miscellaneous
* Add citation to pre-print.

# MotifPeeker 0.99.13

## Bug Fixes
* Fix missing second table in known motif enrichment analysis tabs.

## Miscellaneous
* Add "in Bioc" badge to README.

# MotifPeeker 0.99.12

## Bug Fixes
* Supply `meme_path` and `verbose` to second `motif_enrichment` call in
`get_df_enrichment`.

## Miscellaneous
* Update example reports.
* Add new author.
* Add BioConductor installation instructions to README.


# MotifPeeker 0.99.11

## Miscellaneous
 
* Correct "de-novo motif discovery" term to "motif discovery". STREME does not
perform de-novo motif discovery.
* Add package version to report header.


# MotifPeeker 0.99.9 / 0.99.10

## Bug Fixes

* Fix `download_button()` error when `downloadthis` package is not available.


# MotifPeeker 0.99.8

## Miscellaneous
 
* Optimise examples and remove `\donttest{}` blocks.
* Add GitHub Actions for rworkflows without MEME Suite.


# MotifPeeker 0.99.7

## New Features
* Replace `workers` argument with `BPPARAM`. Give users more control over the
BiocParallel implementation.

## Miscellaneous
 
* Remove `cat()` calls in functions.
* Implement helper `check_input()` to validate input before passing them to
  other functions.
* Run examples and tests only if MEME Suite is detected (only for functions
which require MEME Suite).


# MotifPeeker 0.99.5 / 0.99.6

## Miscellaneous
 
* Replace `magrittr` import by `dplyr::%>%`.
* Reduce the number of exported functions.
* Move utility functions to 'utilities.R'.
* Allow vignettes to run without MEME suite installed.
* Remove `stopper()` wrapper around `stop()`.
* Use message() for parallel executions


# MotifPeeker 0.99.4

## Miscellaneous
 
* Switch to a smaller file to download in `check_ENCODE` example.
* Move some code outside `\donttest{}` to prevent `BiocCheck()` error about
  missing examples.


# MotifPeeker 0.99.3

## Miscellaneous
 
* Wrap certain examples under `\donttest{}` to reduce R CMD CHECK runtime.
* [GitHub] Add `CODECOV_TOKEN` secret to `rworkflows`.
* Skip running tests which require download if offline.


# MotifPeeker 0.99.2

## Miscellaneous
 
* Substitute `system()` with `system2()`.
* Reduce `denovo_motifs` in examples and tests to reduce R CMD CHECK runtime.
* Add `.BBSoptions` to `.Rbuildignore`.


# MotifPeeker 0.99.1

## Miscellaneous
 
* `.BBSoptions` added to skip Windows builders on Bioconductor.


# MotifPeeker 0.99.0

## New features
 
* `MotifPeeker` submitted to Bioconductor.
