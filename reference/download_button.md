# Create a download button

Creates a download button for a file or directory, suitable to embed
into an HTML report.

## Usage

``` r
download_button(
  path,
  type,
  button_label,
  output_name = NULL,
  button_type = "success",
  has_icon = TRUE,
  icon = "fa fa-save",
  add_button = TRUE,
  ...
)
```

## Arguments

- path:

  A character string specifying the path to the file or directory.

- type:

  A character string specifying the type of download. Either `"file"` or
  `"dir"`.

- button_label:

  Character (HTML), button label

- output_name:

  Name of of the output file. If not specified, it will take the source
  file's name if one file is specified. In case of multiple files, the
  `output_name` must be specified.

- button_type:

  Character, one of the standard Bootstrap types

- has_icon:

  Specify whether to include fontawesome icons in the button label

- icon:

  Fontawesome tag e.g.: "fa fa-save"

- add_button:

  A logical indicating whether to add the download button to the HTML
  report. (default = TRUE)

- ...:

  Arguments passed on to
  [`downloadthis::download_file`](https://rdrr.io/pkg/downloadthis/man/download_file.html)

  `self_contained`

  :   A boolean to specify whether your HTML output is self-contained.
      Default to `FALSE`.

## Value

`htmltools::`[`tag`](https://rstudio.github.io/htmltools/reference/builder.html),
`<button>`

## See also

[`download_file`](https://rdrr.io/pkg/downloadthis/man/download_file.html)
