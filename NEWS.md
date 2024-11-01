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
