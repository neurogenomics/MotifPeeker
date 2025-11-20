# Troubleshooting

**Updated:** ***Nov-20-2025***

This vignette provides troubleshooting tips for common issues
encountered when using the `MotifPeeker` package.

If you encounter an issue that is not covered, please open an issue on
the [GitHub
repository](https://github.com/neurogenomics/MotifPeeker/issues).

  

##### MEME Suite Related

1.  **Error: Cannot find MEME Suite**  
    If You have ensured that the MEME Suite is installed, but still
    encounter this error, set the path to the MEME suite binaries
    (`.../meme/bin/`) using the `meme_path` parameter in the
    [`MotifPeeker()`](https://neurogenomics.github.io/MotifPeeker/reference/MotifPeeker.md)
    function call.

2.  **Error: Failed to generate .html file.**  
    Please ensure that the [Perl dependencies required by the MEME
    Suite](https://meme-suite.org/meme/doc/install.html#prereq_perl) are
    installed, particularly `XML::Parser`, which can be installed using
    the following command in the terminal:  
    `bash cpan install XML::Parser`

##### `MotifPeeker()` Related

1.  **Function takes too long to run**  
    It is likely motif discovery is what is taking too long to run. Try
    reducing the number of workers if you are running out of memory
    while running the
    [`MotifPeeker()`](https://neurogenomics.github.io/MotifPeeker/reference/MotifPeeker.md)
    function.  
    Additionally, follow the [runtime
    guidance](https://neurogenomics.github.io/MotifPeeker/articles/MotifPeeker.html#runtime)
    for
    [`MotifPeeker()`](https://neurogenomics.github.io/MotifPeeker/reference/MotifPeeker.md).

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
    ## loaded via a namespace (and not attached):
    ##  [1] digest_0.6.38     desc_1.4.3        R6_2.6.1          fastmap_1.2.0    
    ##  [5] xfun_0.54         cachem_1.1.0      knitr_1.50        htmltools_0.5.8.1
    ##  [9] rmarkdown_2.30    lifecycle_1.0.4   cli_3.6.5         sass_0.4.10      
    ## [13] pkgdown_2.2.0     textshaping_1.0.1 jquerylib_0.1.4   systemfonts_1.2.3
    ## [17] compiler_4.5.1    tools_4.5.1       ragg_1.4.0        bslib_0.9.0      
    ## [21] evaluate_1.0.5    yaml_2.3.10       jsonlite_2.0.0    rlang_1.1.6      
    ## [25] fs_1.6.6          htmlwidgets_1.6.4

  
