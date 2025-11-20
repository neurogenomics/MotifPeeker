# Check for input validity and pass to appropriate function

Check for input validity and pass to appropriate function

## Usage

``` r
check_input(x, type, FUN, inverse = FALSE, ...)
```

## Arguments

- x:

  The input to check.

- type:

  The type of input to check for. Supported types are:

  - `jaspar_id`: JASPAR identifier.

  - `motif`: \`universalmotif\` motif object.

  - `encode_id`: ENCODE identifier.

- FUN:

  The function to pass the input to.

- inverse:

  Logical indicating whether to return the input if it is invalid for
  the specified \`type\`.

- ...:

  Additional arguments to pass to the \`FUN\` function.

## Value

\`x\` if the input is invalid for the specified \`type\`, or else the
output of the \`FUN\` function. If \`inverse = TRUE\`, the function
returns the output of the \`FUN\` function if the input is valid, or
else \`x\`.
