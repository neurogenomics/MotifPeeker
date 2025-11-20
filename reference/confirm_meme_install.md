# Stop if MEME suite is not installed

Stop if MEME suite is not installed

## Usage

``` r
confirm_meme_install(meme_path = NULL, continue = FALSE)
```

## Arguments

- meme_path:

  path to `meme/bin/` (optional). Defaut: `NULL`, searches "MEME_PATH"
  environment variable or "meme_path" option for path to "meme/bin/".

- continue:

  Continue code execution if MEME suite is not installed.

## Value

Null

## See also

[`check_meme_install`](https://rdrr.io/pkg/memes/man/check_meme_install.html)
