# Docker/Singularity Containers

**Updated:** ***Nov-20-2025***

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
    ## [1] MotifPeeker_1.3.1
    ## 
    ## loaded via a namespace (and not attached):
    ##   [1] DBI_1.2.3                   bitops_1.0-9               
    ##   [3] gridExtra_2.3               httr2_1.2.1                
    ##   [5] rlang_1.1.6                 magrittr_2.0.4             
    ##   [7] matrixStats_1.5.0           compiler_4.5.1             
    ##   [9] RSQLite_2.4.4               systemfonts_1.2.3          
    ##  [11] vctrs_0.6.5                 pkgconfig_2.0.3            
    ##  [13] crayon_1.5.3                fastmap_1.2.0              
    ##  [15] dbplyr_2.5.1                XVector_0.50.0             
    ##  [17] memes_1.18.0                ca_0.71.1                  
    ##  [19] Rsamtools_2.26.0            rmarkdown_2.30             
    ##  [21] tzdb_0.5.0                  ragg_1.4.0                 
    ##  [23] purrr_1.2.0                 bit_4.6.0                  
    ##  [25] xfun_0.54                   ggseqlogo_0.2              
    ##  [27] cachem_1.1.0                cigarillo_1.0.0            
    ##  [29] jsonlite_2.0.0              blob_1.2.4                 
    ##  [31] DelayedArray_0.36.0         BiocParallel_1.44.0        
    ##  [33] parallel_4.5.1              R6_2.6.1                   
    ##  [35] bslib_0.9.0                 RColorBrewer_1.1-3         
    ##  [37] rtracklayer_1.70.0          GenomicRanges_1.62.0       
    ##  [39] jquerylib_0.1.4             Rcpp_1.1.0                 
    ##  [41] Seqinfo_1.0.0               assertthat_0.2.1           
    ##  [43] SummarizedExperiment_1.40.0 iterators_1.0.14           
    ##  [45] knitr_1.50                  readr_2.1.6                
    ##  [47] IRanges_2.44.0              Matrix_1.7-3               
    ##  [49] tidyselect_1.2.1            abind_1.4-8                
    ##  [51] yaml_2.3.10                 viridis_0.6.5              
    ##  [53] TSP_1.2-5                   codetools_0.2-20           
    ##  [55] curl_7.0.0                  lattice_0.22-7             
    ##  [57] tibble_3.3.0                Biobase_2.70.0             
    ##  [59] S7_0.2.1                    evaluate_1.0.5             
    ##  [61] desc_1.4.3                  heatmaply_1.6.0            
    ##  [63] BiocFileCache_3.0.0         universalmotif_1.28.0      
    ##  [65] Biostrings_2.78.0           pillar_1.11.1              
    ##  [67] filelock_1.0.3              MatrixGenerics_1.22.0      
    ##  [69] DT_0.34.0                   foreach_1.5.2              
    ##  [71] stats4_4.5.1                plotly_4.11.0              
    ##  [73] generics_0.1.4              RCurl_1.98-1.17            
    ##  [75] S4Vectors_0.48.0            hms_1.1.4                  
    ##  [77] ggplot2_4.0.1               scales_1.4.0               
    ##  [79] glue_1.8.0                  lazyeval_0.2.2             
    ##  [81] tools_4.5.1                 dendextend_1.19.1          
    ##  [83] BiocIO_1.20.0               data.table_1.17.8          
    ##  [85] BSgenome_1.78.0             webshot_0.5.5              
    ##  [87] GenomicAlignments_1.46.0    registry_0.5-1             
    ##  [89] fs_1.6.6                    XML_3.99-0.20              
    ##  [91] grid_4.5.1                  tidyr_1.3.1                
    ##  [93] seriation_1.5.8             restfulr_0.0.16            
    ##  [95] cli_3.6.5                   rappdirs_0.3.3             
    ##  [97] textshaping_1.0.1           S4Arrays_1.10.0            
    ##  [99] viridisLite_0.4.2           dplyr_1.1.4                
    ## [101] gtable_0.3.6                sass_0.4.10                
    ## [103] digest_0.6.38               BiocGenerics_0.56.0        
    ## [105] SparseArray_1.10.1          rjson_0.2.23               
    ## [107] htmlwidgets_1.6.4           farver_2.1.2               
    ## [109] memoise_2.0.1               htmltools_0.5.8.1          
    ## [111] pkgdown_2.2.0               lifecycle_1.0.4            
    ## [113] httr_1.4.7                  MASS_7.3-65                
    ## [115] bit64_4.6.0-1

  
