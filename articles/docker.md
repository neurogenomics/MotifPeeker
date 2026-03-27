# Docker/Singularity Containers

**Updated:** ***Mar-27-2026***

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
  your password to be.  
- Change the paths supplied to the `-v` flags for your particular use
  case.
- The `-d` ensures the container will run in “detached” mode, which
  means it will persist even after you’ve closed your command line
  session.  
- The username will be *“rstudio”* by default.  
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

``` r
utils::sessionInfo()
```

    ## R version 4.5.1 (2025-06-13)
    ## Platform: x86_64-pc-linux-gnu
    ## Running under: Ubuntu 24.04.2 LTS
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
    ## [1] MotifPeeker_1.3.2
    ## 
    ## loaded via a namespace (and not attached):
    ##   [1] DBI_1.3.0                   bitops_1.0-9               
    ##   [3] gridExtra_2.3               httr2_1.2.2                
    ##   [5] rlang_1.1.7                 magrittr_2.0.4             
    ##   [7] otel_0.2.0                  matrixStats_1.5.0          
    ##   [9] compiler_4.5.1              RSQLite_2.4.6              
    ##  [11] systemfonts_1.2.3           vctrs_0.7.2                
    ##  [13] pkgconfig_2.0.3             crayon_1.5.3               
    ##  [15] fastmap_1.2.0               dbplyr_2.5.2               
    ##  [17] XVector_0.50.0              memes_1.18.0               
    ##  [19] ca_0.71.1                   Rsamtools_2.26.0           
    ##  [21] rmarkdown_2.31              tzdb_0.5.0                 
    ##  [23] ragg_1.4.0                  purrr_1.2.1                
    ##  [25] bit_4.6.0                   xfun_0.57                  
    ##  [27] ggseqlogo_0.2.2             cachem_1.1.0               
    ##  [29] cigarillo_1.0.0             jsonlite_2.0.0             
    ##  [31] blob_1.3.0                  DelayedArray_0.36.0        
    ##  [33] BiocParallel_1.44.0         parallel_4.5.1             
    ##  [35] R6_2.6.1                    bslib_0.10.0               
    ##  [37] RColorBrewer_1.1-3          rtracklayer_1.70.1         
    ##  [39] GenomicRanges_1.62.1        jquerylib_0.1.4            
    ##  [41] Rcpp_1.1.1                  Seqinfo_1.0.0              
    ##  [43] assertthat_0.2.1            SummarizedExperiment_1.40.0
    ##  [45] iterators_1.0.14            knitr_1.51                 
    ##  [47] readr_2.2.0                 IRanges_2.44.0             
    ##  [49] Matrix_1.7-3                tidyselect_1.2.1           
    ##  [51] abind_1.4-8                 yaml_2.3.12                
    ##  [53] viridis_0.6.5               TSP_1.2.7                  
    ##  [55] codetools_0.2-20            curl_7.0.0                 
    ##  [57] lattice_0.22-7              tibble_3.3.1               
    ##  [59] Biobase_2.70.0              S7_0.2.1                   
    ##  [61] evaluate_1.0.5              desc_1.4.3                 
    ##  [63] heatmaply_1.6.0             BiocFileCache_3.0.0        
    ##  [65] universalmotif_1.28.0       Biostrings_2.78.0          
    ##  [67] pillar_1.11.1               filelock_1.0.3             
    ##  [69] MatrixGenerics_1.22.0       DT_0.34.0                  
    ##  [71] foreach_1.5.2               stats4_4.5.1               
    ##  [73] plotly_4.12.0               generics_0.1.4             
    ##  [75] RCurl_1.98-1.18             hms_1.1.4                  
    ##  [77] S4Vectors_0.48.0            ggplot2_4.0.2              
    ##  [79] scales_1.4.0                glue_1.8.0                 
    ##  [81] lazyeval_0.2.2              tools_4.5.1                
    ##  [83] dendextend_1.19.1           BiocIO_1.20.0              
    ##  [85] data.table_1.18.2.1         BSgenome_1.78.0            
    ##  [87] webshot_0.5.5               GenomicAlignments_1.46.0   
    ##  [89] registry_0.5-1              fs_2.0.1                   
    ##  [91] XML_3.99-0.23               grid_4.5.1                 
    ##  [93] tidyr_1.3.2                 seriation_1.5.8            
    ##  [95] restfulr_0.0.16             cli_3.6.5                  
    ##  [97] rappdirs_0.3.4              textshaping_1.0.1          
    ##  [99] S4Arrays_1.10.1             viridisLite_0.4.3          
    ## [101] dplyr_1.2.0                 gtable_0.3.6               
    ## [103] sass_0.4.10                 digest_0.6.39              
    ## [105] BiocGenerics_0.56.0         SparseArray_1.10.9         
    ## [107] rjson_0.2.23                htmlwidgets_1.6.4          
    ## [109] farver_2.1.2                memoise_2.0.1              
    ## [111] htmltools_0.5.9             pkgdown_2.2.0              
    ## [113] lifecycle_1.0.5             httr_1.4.8                 
    ## [115] MASS_7.3-65                 bit64_4.6.0-1

  
