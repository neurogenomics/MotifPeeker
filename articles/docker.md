# Docker/Singularity Containers

**Updated:** ***Sep-08-2026***

## Installation

MotifPeeker is now available via
[ghcr.io](https://ghcr.io/ghcr.io/neurogenomics/motifpeeker) as a
containerised environment with Rstudio and all necessary dependencies
pre-installed.

### Method 1: via Docker

First, [install Docker](https://docs.docker.com/get-docker/) if you have
not already.

Create an image of the [Docker](https://www.docker.com/) container in
command line:

``` bash
docker pull ghcr.io/neurogenomics/motifpeeker
```

Once the image has been created, you can launch it with:

``` bash
docker run \
    -d \
    -e ROOT=true \
    -e PASSWORD="<your_password>" \
    -v ~/Desktop:/Desktop \
    -v /Volumes:/Volumes \
    -p 8900:8787 \
    ghcr.io/neurogenomics/motifpeeker
```

#### NOTES

- Make sure to replace `<your_password>` above with whatever you want
  your password to be.\
- Change the paths supplied to the `-v` flags for your particular use
  case.
- The `-d` ensures the container will run in “detached” mode, which
  means it will persist even after you’ve closed your command line
  session.\
- The username will be *“rstudio”* by default.\
- Optionally, you can also install the [Docker
  Desktop](https://www.docker.com/products/docker-desktop/) to easily
  manage your containers.

### Method 2: via Singularity

If you are using a system that does not allow Docker (as is the case for
many institutional computing clusters), you can instead [install Docker
images via
Singularity](https://docs.sylabs.io/guides/2.6/user-guide/singularity_and_docker.html).

``` bash
singularity pull docker://ghcr.io/neurogenomics/motifpeeker
```

For troubleshooting, see the [Singularity
documentation](https://docs.sylabs.io/guides/latest/user-guide/singularity_and_docker.html#github-container-registry).

## Usage

Finally, launch the containerised Rstudio by entering the following URL
in any web browser: *<http://localhost:8900/>*

## Session Info

`utils``::`[`sessionInfo`](https://rdrr.io/r/utils/sessionInfo.html)`(``)`

    ## R version 4.6.1 (2026-06-24)
    ## Platform: x86_64-pc-linux-gnu
    ## Running under: Ubuntu 24.04.4 LTS
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3 
    ## LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.26.so;  LAPACK version 3.12.0
    ## 
    ## locale:
    ##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
    ##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
    ##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
    ##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
    ##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
    ## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
    ## 
    ## time zone: UTC
    ## tzcode source: system (glibc)
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] MotifPeeker_1.5.1
    ## 
    ## loaded via a namespace (and not attached):
    ##   [1] DBI_1.3.0                   bitops_1.1-0               
    ##   [3] gridExtra_2.3.1             httr2_1.3.0                
    ##   [5] rlang_1.3.0                 magrittr_2.0.5             
    ##   [7] otel_0.2.0                  matrixStats_1.5.0          
    ##   [9] compiler_4.6.1              RSQLite_3.53.3             
    ##  [11] systemfonts_1.3.2           vctrs_0.7.3                
    ##  [13] pkgconfig_2.0.3             crayon_1.5.3               
    ##  [15] fastmap_1.2.0               dbplyr_2.6.0               
    ##  [17] XVector_0.53.0              memes_1.21.0               
    ##  [19] ca_0.71.1                   Rsamtools_2.29.0           
    ##  [21] rmarkdown_2.32              tzdb_0.5.0                 
    ##  [23] ragg_1.5.2                  purrr_1.2.2                
    ##  [25] bit_4.6.0                   xfun_0.60                  
    ##  [27] cachem_1.1.0                cigarillo_1.3.1            
    ##  [29] jsonlite_2.0.0              blob_1.3.0                 
    ##  [31] DelayedArray_0.39.6         BiocParallel_1.47.0        
    ##  [33] parallel_4.6.1              R6_2.6.1                   
    ##  [35] bslib_0.12.0                RColorBrewer_1.1-3         
    ##  [37] rtracklayer_1.73.0          GenomicRanges_1.65.4       
    ##  [39] jquerylib_0.1.4             Rcpp_1.1.2                 
    ##  [41] Seqinfo_1.3.2               assertthat_0.2.1           
    ##  [43] SummarizedExperiment_1.43.0 iterators_1.0.14           
    ##  [45] knitr_1.52                  readr_2.2.0                
    ##  [47] IRanges_2.47.5              BiocBaseUtils_1.15.1       
    ##  [49] Matrix_1.7-6                tidyselect_1.2.1           
    ##  [51] abind_1.4-8                 yaml_2.3.12                
    ##  [53] viridis_0.6.5               TSP_1.2.7                  
    ##  [55] codetools_0.2-20            curl_8.0.0                 
    ##  [57] lattice_0.23-1              tibble_3.3.1               
    ##  [59] Biobase_2.73.2              S7_0.2.2                   
    ##  [61] evaluate_1.0.5              desc_1.4.3                 
    ##  [63] heatmaply_1.6.0             BiocFileCache_3.3.0        
    ##  [65] universalmotif_1.31.46      Biostrings_2.81.9          
    ##  [67] pillar_1.11.1               filelock_1.0.3             
    ##  [69] MatrixGenerics_1.25.0       DT_0.34.0                  
    ##  [71] foreach_1.5.2               stats4_4.6.1               
    ##  [73] plotly_4.12.1               generics_0.1.4             
    ##  [75] RCurl_1.98-1.20             hms_1.1.4                  
    ##  [77] S4Vectors_0.51.9            ggplot2_4.0.3              
    ##  [79] scales_1.4.0                glue_1.8.1                 
    ##  [81] tools_4.6.1                 dendextend_1.19.1          
    ##  [83] BiocIO_1.23.3               data.table_1.18.6.1        
    ##  [85] BSgenome_1.81.1             webshot_0.5.5              
    ##  [87] GenomicAlignments_1.49.2    registry_0.5-1             
    ##  [89] fs_2.1.0                    XML_3.99-0.24              
    ##  [91] grid_4.6.1                  tidyr_1.3.2                
    ##  [93] seriation_1.5.8             restfulr_0.0.17            
    ##  [95] cli_3.6.6                   textshaping_1.0.5          
    ##  [97] S4Arrays_1.13.0             viridisLite_0.4.3          
    ##  [99] dplyr_1.2.1                 gtable_0.3.6               
    ## [101] sass_0.4.10                 digest_0.6.39              
    ## [103] BiocGenerics_0.59.12        SparseArray_1.13.2         
    ## [105] rjson_0.2.23                htmlwidgets_1.6.4          
    ## [107] farver_2.1.2                memoise_2.0.1              
    ## [109] htmltools_0.5.9             pkgdown_2.2.1              
    ## [111] lifecycle_1.0.5             httr_1.4.9                 
    ## [113] MASS_7.3-66                 bit64_4.8.6

\
