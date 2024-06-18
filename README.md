MotifPeeker
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
README updated: <i>Jun-18-2024</i>  
</h4>

## `MotifPeeker`: Benchmarking Epigenomic Profiling Methods Using Motif Enrichment

### MotifPeeker is used to compare and analyse datasets from epigenomic profiling methods with motif enrichment as the key benchmark. The package outputs an HTML report consisting of three sections: (1. General Metrics) Overview of peaks-related general metrics for the datasets (FRiP scores, peak widths and motif-summit distances). (2. Known Motif Enrichment Analysis) Statistics for the frequency of user-provided motifs enriched in the datasets. (3. De-Novo Motif Enrichment Analysis) Statistics for the frequency of de-novo discovered motifs enriched in the datasets and compared with known motifs.

<!-- If you use `MotifPeeker`, please cite:  -->
<!-- > author1, author2, author3 (publicationYear) articleTitle, *journalName*; volumeNumber, [linkToPublication](linkToPublication) -->

## Installation

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
    ##  [4] compiler_4.4.1      BiocManager_1.30.23 rvcheck_0.2.1      
    ##  [7] scales_1.3.0        yaml_2.3.8          fastmap_1.2.0      
    ## [10] here_1.0.1          ggplot2_3.5.1       R6_2.5.1           
    ## [13] knitr_1.47          yulab.utils_0.1.4   tibble_3.2.1       
    ## [16] desc_1.4.3          dlstats_0.1.7       rprojroot_2.0.4    
    ## [19] munsell_0.5.1       pillar_1.9.0        RColorBrewer_1.1-3 
    ## [22] rlang_1.1.4         utf8_1.2.4          cachem_1.1.0       
    ## [25] badger_0.2.4        xfun_0.45           fs_1.6.4           
    ## [28] memoise_2.0.1       cli_3.6.2           magrittr_2.0.3     
    ## [31] rworkflows_1.0.1    digest_0.6.35       grid_4.4.1         
    ## [34] rstudioapi_0.16.0   lifecycle_1.0.4     vctrs_0.6.5        
    ## [37] evaluate_0.24.0     glue_1.7.0          data.table_1.15.4  
    ## [40] fansi_1.0.6         colorspace_2.1-0    rmarkdown_2.27     
    ## [43] tools_4.4.1         pkgconfig_2.0.3     htmltools_0.5.8.1

</details>
