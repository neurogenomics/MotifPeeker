# Read a motif file

`read_motif_file()` reads a motif file and converts to a PWM. The
function supports multiple motif formats, including "homer", "jaspar",
"meme", "transfac" and "uniprobe".

## Usage

``` r
read_motif_file(motif_file, file_format = "auto", verbose = FALSE)
```

## Arguments

- motif_file:

  Path to a motif file or a
  [`universalmotif-class`](https://rdrr.io/pkg/universalmotif/man/universalmotif-class.html)
  object.

- file_format:

  Character string specifying the format of the motif file. The options
  are "homer", "jaspar", "meme", "transfac" and "uniprobe"

- verbose:

  A logical indicating whether to print messages.

## Value

A `universalmotif` motif object.

## Examples

``` r
motif_file <- system.file("extdata",
                          "motif_MA1930.2.jaspar",
                          package = "MotifPeeker")
res <- read_motif_file(motif_file = motif_file,
                       file_format = "jaspar")
print(res)
#> 
#>        Motif name:   MA1930.2
#>    Alternate name:   CTCF
#>          Alphabet:   DNA
#>              Type:   PCM
#>           Strands:   +-
#>          Total IC:   20.69
#>       Pseudocount:   1
#>         Consensus:   CTGCAGTNCNNNNNNNNNNCCASYAGRKGGCRS
#>      Target sites:   2576
#> 
#>      C    T    G    C    A    G    T    N    C    N   N   N    N   N   N   N
#> A  293  242   41   86 1986  445  158  346  453  497 714 536  467 664 563 593
#> C 1497  107   35 2129  127  366  278  324 1333 1129 794 855 1138 604 730 902
#> G  400  144 2476   25  155 1456  179  892  328  419 623 770  561 376 541 494
#> T  386 2083   24  336  308  309 1961 1014  462  531 445 415  410 932 742 587
#>     N    N    N    C    C    A    S    Y    A    G    R    K    G    G    C
#> A 452  560  604  178   38 1906  127  348 2179   32 1140  169   62  119  335
#> C 781  458  300 2074 2515   97 1409 1016   54    9   14   71   14  138 1833
#> G 393 1041 1242  155    9  275  961  175  212 2527 1399 1208 2472 2117   86
#> T 950  517  430  169   14  298   79 1037  131    8   23 1128   28  202  322
#>      R    S
#> A 1021  279
#> C  164 1307
#> G 1161  740
#> T  230  250
```
