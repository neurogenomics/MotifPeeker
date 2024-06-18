<code>MotifPeeker</code><br>Benchmarking Epigenomic Profiling Methods
Using Motif Enrichment
================
<img src='https://github.com/neurogenomics/MotifPeeker/raw/master/inst/hex/hex.png' title='Hex sticker for MotifPeeker' height='300'><br>
[![License:
GPL-3](https://img.shields.io/badge/license-GPL--3-blue.svg)](https://cran.r-project.org/web/licenses/GPL-3)
[![](https://img.shields.io/badge/devel%20version-0.99.0-black.svg)](https://github.com/neurogenomics/MotifPeeker)
[![](https://img.shields.io/github/languages/code-size/neurogenomics/MotifPeeker.svg)](https://github.com/neurogenomics/MotifPeeker)
[![](https://img.shields.io/github/last-commit/neurogenomics/MotifPeeker.svg)](https://github.com/neurogenomics/MotifPeeker/commits/master)
<br> [![R build
status](https://github.com/neurogenomics/MotifPeeker/workflows/rworkflows/badge.svg)](https://github.com/neurogenomics/MotifPeeker/actions)
[![](https://codecov.io/gh/neurogenomics/MotifPeeker/branch/master/graph/badge.svg)](https://app.codecov.io/gh/neurogenomics/MotifPeeker)
<br>
<a href='https://app.codecov.io/gh/neurogenomics/MotifPeeker/tree/master' target='_blank'><img src='https://codecov.io/gh/neurogenomics/MotifPeeker/branch/master/graphs/icicle.svg' title='Codecov icicle graph' width='200' height='50' style='vertical-align: top;'></a>  
<h4>  
Authors: <i>Hiranyamaya Dash</i>  
</h4>
<h4>  
Updated: <i>Jun-18-2024</i>  
</h4>

# Introduction

`MotifPeeker` is used to compare and analyse datasets from epigenomic
profiling methods with motif enrichment as the key benchmark. The
package outputs an HTML report consisting of three sections:

1.  **General Metrics**: Overview of peaks-related general metrics for
    the datasets (FRiP scores, peak widths and motif-summit distances).
2.  **Known Motif Enrichment Analysis**: Statistics for the frequency of
    user-provided motifs enriched in the datasets.
3.  **De-Novo Motif Enrichment Analysis**: Statistics for the frequency
    of de-novo discovered motifs enriched in the datasets and compared
    with known motifs.

<!-- If you use `MotifPeeker`, please cite:  -->
<!-- >  -->

# Installation

`MotifPeeker` uses
[`memes`](https://www.bioconductor.org/packages/release/bioc/html/memes.html)
which relies on a local install of the [MEME
suite](https://meme-suite.org/meme/). Installation instructions can be
found
[here](https://www.bioconductor.org/packages/release/bioc/vignettes/memes/inst/doc/install_guide.html).

Once the MEME suite is installed, `MotifPeeker` can be installed using
the following code:

``` r
if(!require("remotes")) install.packages("remotes")

remotes::install_github("neurogenomics/MotifPeeker")
library(MotifPeeker)
```

## Documentation

### [Website](https://neurogenomics.github.io/MotifPeeker)

### [Getting started](https://neurogenomics.github.io/MotifPeeker/articles/MotifPeeker)

<hr>

## Session Info

<details>

``` r
utils::sessionInfo()
```

    ## R version 4.4.1 (2024-06-14)
    ## Platform: aarch64-apple-darwin20
    ## Running under: macOS Sonoma 14.5
    ## 
    ## Matrix products: default
    ## BLAS:   /Library/Frameworks/R.framework/Versions/4.4-arm64/Resources/lib/libRblas.0.dylib 
    ## LAPACK: /Library/Frameworks/R.framework/Versions/4.4-arm64/Resources/lib/libRlapack.dylib;  LAPACK version 3.12.0
    ## 
    ## locale:
    ## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
    ## 
    ## time zone: Europe/London
    ## tzcode source: internal
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] gtable_0.3.5        jsonlite_1.8.8      renv_1.0.7         
    ##  [4] dplyr_1.1.4         compiler_4.4.1      BiocManager_1.30.23
    ##  [7] tidyselect_1.2.1    rvcheck_0.2.1       scales_1.3.0       
    ## [10] yaml_2.3.8          fastmap_1.2.0       here_1.0.1         
    ## [13] ggplot2_3.5.1       R6_2.5.1            generics_0.1.3     
    ## [16] knitr_1.47          yulab.utils_0.1.4   tibble_3.2.1       
    ## [19] desc_1.4.3          dlstats_0.1.7       rprojroot_2.0.4    
    ## [22] munsell_0.5.1       pillar_1.9.0        RColorBrewer_1.1-3 
    ## [25] rlang_1.1.4         utf8_1.2.4          cachem_1.1.0       
    ## [28] badger_0.2.4        xfun_0.45           fs_1.6.4           
    ## [31] memoise_2.0.1       cli_3.6.2           magrittr_2.0.3     
    ## [34] rworkflows_1.0.1    digest_0.6.35       grid_4.4.1         
    ## [37] rstudioapi_0.16.0   lifecycle_1.0.4     vctrs_0.6.5        
    ## [40] data.table_1.15.4   evaluate_0.24.0     glue_1.7.0         
    ## [43] fansi_1.0.6         colorspace_2.1-0    rmarkdown_2.27     
    ## [46] tools_4.4.1         pkgconfig_2.0.3     htmltools_0.5.8.1

</details>
