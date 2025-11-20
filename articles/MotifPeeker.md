# Get started

**Updated:** ***Nov-20-2025***

## Overview

The *MotifPeeker* package facilitates the comparison and validation of
datasets from epigenomic profiling methods, using motif enrichment as
the key benchmark. The package generates a comprehensive summary report
with results from various downstream analyses by processing peak,
alignment, and motif files. This allows for detailed statistical
analysis of multiple epigenomic datasets without any coding, ensuring
both accessibility and robustness.

## Introduction

The rapidly advancing field of epigenomics has led to the development of
various techniques for profiling protein interactions with DNA,
enhancing our understanding of gene regulatory mechanisms and genetic
factors behind complex diseases. However, the validation of these newer
methods, such as CUT&RUN, CUT&TAG and TIP-Seq, remains a critical area
that requires further exploration, especially given their potential to
address the challenges of traditional ChIP-Seq.

Common epigenomic profiling techniques rely on target proteins, such as
the transcriptional regulator CTCF, binding to their respective sites on
the DNA to isolate the sequences for sequencing. These binding sites may
contain specific sequences recognised by the transcription factors,
called motifs. Unlike other comparison tools like *ChIPseeker* and
*EpiCompare*, *MotifPeeker* checks for the presence of these motifs in
the sequences enriched from epigenomic profiling methods as a novel
strategy to benchmark them.

At the same time, general metrics like FRiP scores and peak width
distributions are also reported to add more context to the comparisons.
While the goal remains to benchmark different epigenomic datasets,
*MotifPeeker* can also be used to compare the effects of various
downstream processing, such as the thresholds for peak calling and the
choice of the peak caller itself. The package can also help identify
differences arising from different experimental conditions or protocol
optimisations.

## Data

*MotifPeeker* comes with a small subset of two epigenomic datasets
targeting CTCF in HCT116 cells, generated using ChIP-Seq and TIP-Seq.

- ChIP-Seq alignment file (`CTCF_ChIP_alignment.bam`) sourced from the
  ENCODE project ([Accession:
  ENCFF091ODJ](https://www.encodeproject.org/files/ENCFF091ODJ/)).  
- TIP-Seq alignment file (`CTCF_TIP_alignment.bam`) was manually
  processed using the
  [`nf-core/cutandrun`](https://nf-co.re/cutandrun/3.2.2) pipeline. The
  raw read files were sourced from *NIH Sequence Read Archives* ([*ID:
  SRR16963166*](https://trace.ncbi.nlm.nih.gov/Traces/index.html?view=run_browser&acc=SRR16963166)).

The alignment files were processed using the *MACS3* peak caller to
produce their respective peak files with the `q-value` parameter set to
0.01.

Two motif files for CTCF are also bundled with the package:

- JASPAR motif file -
  [MA1930.2](https://jaspar.elixir.no/matrix/MA1930.2/)  
- JASPAR motif file -
  [MA1102.3](https://jaspar.elixir.no/matrix/MA1102.3/)

Please note that the peaks and alignments included are a very small
subset (*chr10:65,654,529-74,841,155*) of the actual data. It only
serves as an example to demonstrate the package and run tests to
maintain the integrity of the package.

## Installation

`MotifPeeker` uses
[`memes`](https://www.bioconductor.org/packages/release/bioc/html/memes.html)
which relies on a local install of the [MEME
suite](https://meme-suite.org/meme/), which can be installed as follows:

``` bash
MEME_VERSION=5.5.5  # or the latest version

wget https://meme-suite.org/meme/meme-software/$MEME_VERSION/meme-$MEME_VERSION.tar.gz
tar zxf meme-$MEME_VERSION.tar.gz
cd meme-$MEME_VERSION
./configure --prefix=$HOME/meme --with-url=http://meme-suite.org/ \
--enable-build-libxml2 --enable-build-libxslt
make
make install

# Add to PATH
echo 'export PATH=$HOME/meme/bin:$HOME/meme/libexec/meme-$MEME_VERSION:$PATH' >> ~/.bashrc
echo 'export MEME_BIN=$HOME/meme/bin' >> ~/.bashrc
source ~/.bashrc
```

**NOTE:** It is important that Perl dependencies associated with MEME
suite are also installed, particularly `XML::Parser`, which can be
installed using the following command in the terminal:

``` bash
cpan install XML::Parser
```

For more information, refer to the [Perl dependency section of the MEME
suite](https://meme-suite.org/meme/doc/install.html#prereq_perl).

Once the MEME suite and its associated Perl dependencies are installed,
install and load `MotifPeeker`:

``` r
# Install latest version of MotifPeeker
BiocManager::install("MotifPeeker", version = "devel", dependencies = TRUE) 

# Load the package
library(MotifPeeker)
```

Alternatively, you can use the [Docker/Singularity
container](https://neurogenomics.github.io/MotifPeeker/articles/docker.html)
to run the package out-of-the-box.

## Running *MotifPeeker*

In this example, we will compare the bundled ChIP-Seq dataset against
the TIP-Seq dataset.

### Load the package

Once installed, load the package using:

``` r
library(MotifPeeker)
```

### Load the example datasets

``` r
## Peak files processed using read_peak_file()
data("CTCF_ChIP_peaks", package = "MotifPeeker")
data("CTCF_TIP_peaks", package = "MotifPeeker")

## Motif files processed using read_motif_file()
data("motif_MA1102.3", package = "MotifPeeker")
data("motif_MA1930.2", package = "MotifPeeker")
```

### Prepare input data

#### Peak Files

*MotifPeeker* accepts lists of both `GRanges` objects produced by
[`read_peak_file()`](https://neurogenomics.github.io/MotifPeeker/reference/read_peak_file.md),
or paths to the *MACS2/3* `.narrowPeak` files or *SEACR* `.bed` files,
or ENCODE file IDs to automatically download the respective files.

``` r
## MACS2/3 peak files
peak_files <- list("/path/to/peak1.narrowPeak", "/path/to/peak2.narrowPeak")

## or SEACR peak files
peak_files <- list("/path/to/peak1.bed", "/path/to/peak2.bed")
```

In this example, we will use the bundled `GRanges` peaks:

``` r
peak_files <- list(CTCF_ChIP_peaks, CTCF_TIP_peaks)
```

#### Alignment Files

Optionally provide a list of path to `.bam` alignment files, or ENCODE
file IDs to generate additional comparisons like FRiP scores.

In this example, we will use the built-in alignment files.

``` r
## Alignment files
CTCF_ChIP_alignment <- system.file("extdata", "CTCF_ChIP_alignment.bam",
                                    package = "MotifPeeker")
CTCF_TIP_alignment <- system.file("extdata", "CTCF_TIP_alignment.bam",
                                    package = "MotifPeeker")

alignment_files <- list(CTCF_ChIP_alignment, CTCF_TIP_alignment)
```

#### Genome Build

A character string or a `BSgenome` object specifying the genome build of
the datasets.

``` r
## BSgenome object
genome_build <- BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
```

Or, you can use the abbreviated genome build names:

``` r
genome_build <- "hg38"  # Other abbreviations: "hg19", "mm10", "mm39"
```

#### Motif Files

*MotifPeeker* accepts a list of either `universalmotif` objects, or
paths to the supported motif files. Refer to
[`read_motif_file`](https://neurogenomics.github.io/MotifPeeker/reference/read_motif_file.html)
for supported file formats.

``` r
## JASPAR motif files
motif_files <- list("/path/to/motif1.jaspar", "/path/to/motif2.jaspar")
```

It is recommended that you label the motif files by using the
`motif_labels` parameter of the
[`MotifPeeker()`](https://neurogenomics.github.io/MotifPeeker/reference/MotifPeeker.md)
function. This can make it easier to identify the motifs in the report.

In this example, we will use the bundled `universalmotif` motifs:

``` r
motif_files <- list(motif_MA1102.3, motif_MA1930.2)
```

### Run *MotifPeeker*

The report can be generated by using the main function
[`MotifPeeker()`](https://neurogenomics.github.io/MotifPeeker/reference/MotifPeeker.md).
For more run customization, refer to the next sections.

``` r
if (MotifPeeker:::confirm_meme_install(continue = TRUE)) {
    MotifPeeker(
        peak_files = peak_files,
        reference_index = 2,  # Set TIP-seq experiment as reference
        alignment_files = alignment_files,
        exp_labels = c("ChIP", "TIP"),
        exp_type = c("chipseq", "tipseq"),
        genome_build = genome_build,
        motif_files = motif_files,
        cell_counts = NULL,  # No cell-count information
        distance_bootstrap = TRUE,
        bootstrap_n = NULL,
        bootstrap_len = NULL,
        motif_discovery = TRUE,
        motif_discovery_count = 3,  # Discover top 3 motifs
        motif_db = NULL,  # Use default motif database (JASPAR)
        download_buttons = TRUE,
        out_dir = tempdir(),  # Save output in a temporary directory
        BPPARAM = BiocParallel::SerialParam(),  # Use two CPU cores on a 16GB RAM machine
        debug = FALSE,
        quiet = TRUE,
        verbose = TRUE
    )
}
```

#### Required Inputs

These input parameters must be provided:

**Details**

- `peak_files`: A list of path to peak files or `GRanges` objects with
  the peaks to analyse. Currently, only peak files from `MACS2/3`
  (`.narrowPeak`) and `SEACR` (`.bed`) are supported. ENCODE file IDs
  can also be provided to automatically fetch peak file(s) from the
  ENCODE database.  
- `reference_index`: An integer specifying the index of the reference
  dataset in the `peak_files` list to use as reference for various
  comparisons. (default = 1)  
- `genome_build`: A character string or a `BSgenome` object specifying
  the genome build of the datasets. At the moment, only hg38 and hg19
  are supported as abbreviated input.  
- `out_dir`: A character string specifying the output directory to save
  the HTML report and other files.

#### Optional Inputs

These input parameters optional, but *recommended* to add more analyses,
or enhance them:

**Details**

- `alignment_files`: A list of path to alignment files or
  [`Rsamtools::BamFile`](https://rdrr.io/pkg/Rsamtools/man/BamFile-class.html)
  objects with the alignment sequences to analyse. Alignment files are
  used to calculate read-related metrics like FRiP score. ENCODE file
  IDs can also be provided to automatically fetch alignment file(s) from
  the ENCODE database.  
- `exp_labels`: A character vector of labels for each peak file. If not
  provided, capital letters will be used as labels in the report.
- `exp_type`: A character vector of experimental types for each peak
  file.  
  Useful for comparison of different methods. If not provided, all
  datasets will be classified as “unknown” experiment types in the
  report. `exp_type` is used only for labelling. It does not affect the
  analyses. You can also input custom strings. Datasets will be grouped
  as long as they match their respective `exp_type`. Supported
  experimental types are:  
  - `chipseq`: ChIP-seq data  
  - `tipseq`: TIP-seq data  
  - `cuttag`: CUT&Tag data  
  - `cutrun`: CUT&Run data  
- `motif_files`: A character vector of path to motif files, or a vector
  of `universalmotif-class` objects. Required to run Known Motif
  Enrichment Analysis. JASPAR matrix IDs can also be provided to
  automatically fetch motifs from the JASPAR.  
- `motif_labels`: A character vector of labels for each motif file. Only
  used if path to file names are passed in motif_files. If not provided,
  the motif file names will be used as labels.  
- `cell_counts`: An integer vector of experiment cell counts for each
  peak file (if available). Creates additional comparisons based on cell
  counts.  
- `motif_db`: Path to `.meme` format file to use as reference database,
  or a list of `universalmotif-class` objects. Results from motif
  discovery are searched against this database to find similar motifs.
  If not provided, JASPAR CORE database will be used, making this
  parameter **truly optional**. **NOTE**: p-value estimates are
  inaccurate when the database has fewer than 50 entries.

#### Other Options

For more information on additional parameters, please refer to the
documentation for
[`MotifPeeker()`](https://neurogenomics.github.io/MotifPeeker/reference/MotifPeeker.html).

#### Runtime Guidance

For 4 datasets, the runtime is approximately 3 minutes with
motif_discovery disabled. However, motif discovery can take hours to
complete.

To make computation faster, we highly recommend tuning the following
arguments:

**Details**

- `BPPARAM = MulticoreParam(x)`: Running motif discovery in parallel can
  significantly reduce runtime, but it is very memory-intensive,
  consuming upwards of 10GB of RAM per thread. Memory starvation can
  greatly slow the process, so set CPU cores (`x`) with caution.  
- `motif_discovery_count`: The number of motifs to discover per sequence
  group exponentially increases runtime. We recommend no more than 5
  motifs to make a meaningful inference.  
- `trim_seq_width`: Trimming sequences before running motif discovery
  can significantly reduce the search space. Sequence length can
  exponentially increase runtime. We recommend running the script with
  `motif_discovery = FALSE` and studying the motif-summit distance
  distribution under general metrics to find the sequence length that
  captures most motifs. A good starting point is 150 but it can be
  reduced further if appropriate.

### Outputs

`MotifPeeker` generates its output in a new folder within he `out_dir`
directory. The folder is named `MotifPeeker_YYYYMMDD_HHMMSS` and
contains the following files:

- `MotifPeeker.html`: The main HTML report, including all analyses and
  plots.  
- Output from various MEME suite tools in their respecive
  sub-directories, if `save_runfiles` is set to `TRUE`.

### Troubleshooting

If something does not work as expected, refer to
[troubleshooting](https://neurogenomics.github.io/MotifPeeker/articles/troubleshooting.html).

## Future Enhancements

- Add support for outputs from more peak callers.  
- Automatically detect ideal `trim_peak_width` to reduce motif discovery
  runtime.  
- Add more
  [troubleshooting](https://neurogenomics.github.io/MotifPeeker/articles/troubleshooting.html)
  steps to the documentation.

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
    ##   [1] DBI_1.2.3                         bitops_1.0-9                     
    ##   [3] gridExtra_2.3                     httr2_1.2.1                      
    ##   [5] rlang_1.1.6                       magrittr_2.0.4                   
    ##   [7] matrixStats_1.5.0                 compiler_4.5.1                   
    ##   [9] RSQLite_2.4.4                     systemfonts_1.2.3                
    ##  [11] vctrs_0.6.5                       pkgconfig_2.0.3                  
    ##  [13] crayon_1.5.3                      fastmap_1.2.0                    
    ##  [15] dbplyr_2.5.1                      XVector_0.50.0                   
    ##  [17] memes_1.18.0                      ca_0.71.1                        
    ##  [19] Rsamtools_2.26.0                  rmarkdown_2.30                   
    ##  [21] tzdb_0.5.0                        UCSC.utils_1.6.0                 
    ##  [23] ragg_1.4.0                        purrr_1.2.0                      
    ##  [25] bit_4.6.0                         BSgenome.Hsapiens.UCSC.hg38_1.4.5
    ##  [27] xfun_0.54                         ggseqlogo_0.2                    
    ##  [29] cachem_1.1.0                      cigarillo_1.0.0                  
    ##  [31] GenomeInfoDb_1.46.0               jsonlite_2.0.0                   
    ##  [33] blob_1.2.4                        DelayedArray_0.36.0              
    ##  [35] BiocParallel_1.44.0               parallel_4.5.1                   
    ##  [37] R6_2.6.1                          bslib_0.9.0                      
    ##  [39] RColorBrewer_1.1-3                rtracklayer_1.70.0               
    ##  [41] GenomicRanges_1.62.0              jquerylib_0.1.4                  
    ##  [43] Rcpp_1.1.0                        Seqinfo_1.0.0                    
    ##  [45] assertthat_0.2.1                  SummarizedExperiment_1.40.0      
    ##  [47] iterators_1.0.14                  knitr_1.50                       
    ##  [49] readr_2.1.6                       IRanges_2.44.0                   
    ##  [51] Matrix_1.7-3                      tidyselect_1.2.1                 
    ##  [53] abind_1.4-8                       yaml_2.3.10                      
    ##  [55] viridis_0.6.5                     TSP_1.2-5                        
    ##  [57] codetools_0.2-20                  curl_7.0.0                       
    ##  [59] lattice_0.22-7                    tibble_3.3.0                     
    ##  [61] Biobase_2.70.0                    S7_0.2.1                         
    ##  [63] evaluate_1.0.5                    desc_1.4.3                       
    ##  [65] heatmaply_1.6.0                   BiocFileCache_3.0.0              
    ##  [67] universalmotif_1.28.0             Biostrings_2.78.0                
    ##  [69] pillar_1.11.1                     filelock_1.0.3                   
    ##  [71] MatrixGenerics_1.22.0             DT_0.34.0                        
    ##  [73] foreach_1.5.2                     stats4_4.5.1                     
    ##  [75] plotly_4.11.0                     generics_0.1.4                   
    ##  [77] RCurl_1.98-1.17                   S4Vectors_0.48.0                 
    ##  [79] hms_1.1.4                         ggplot2_4.0.1                    
    ##  [81] scales_1.4.0                      glue_1.8.0                       
    ##  [83] lazyeval_0.2.2                    tools_4.5.1                      
    ##  [85] dendextend_1.19.1                 BiocIO_1.20.0                    
    ##  [87] data.table_1.17.8                 BSgenome_1.78.0                  
    ##  [89] webshot_0.5.5                     GenomicAlignments_1.46.0         
    ##  [91] registry_0.5-1                    fs_1.6.6                         
    ##  [93] XML_3.99-0.20                     grid_4.5.1                       
    ##  [95] tidyr_1.3.1                       seriation_1.5.8                  
    ##  [97] restfulr_0.0.16                   cli_3.6.5                        
    ##  [99] rappdirs_0.3.3                    textshaping_1.0.1                
    ## [101] S4Arrays_1.10.0                   viridisLite_0.4.2                
    ## [103] dplyr_1.1.4                       gtable_0.3.6                     
    ## [105] sass_0.4.10                       digest_0.6.38                    
    ## [107] BiocGenerics_0.56.0               SparseArray_1.10.1               
    ## [109] rjson_0.2.23                      htmlwidgets_1.6.4                
    ## [111] farver_2.1.2                      memoise_2.0.1                    
    ## [113] htmltools_0.5.8.1                 pkgdown_2.2.0                    
    ## [115] lifecycle_1.0.4                   httr_1.4.7                       
    ## [117] MASS_7.3-65                       bit64_4.6.0-1

  
