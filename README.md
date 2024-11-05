
# <code>MotifPeeker</code><br>Benchmarking Epigenomic Profiling Methods Using Motif Enrichment

<img
src="https://github.com/neurogenomics/MotifPeeker/raw/master/inst/hex/hex.png"
style="height: 300px !important;" />

[![License: GPL (\>=
3)](https://img.shields.io/badge/license-GPL%20(%3E=%203)-blue.svg)](https://cran.r-project.org/web/licenses/GPL%20(%3E=%203))
[![](https://img.shields.io/badge/devel%20version-0.99.7-black.svg)](https://github.com/neurogenomics/MotifPeeker)
[![](https://img.shields.io/github/languages/code-size/neurogenomics/MotifPeeker.svg)](https://github.com/neurogenomics/MotifPeeker)
[![](https://img.shields.io/github/last-commit/neurogenomics/MotifPeeker.svg)](https://github.com/neurogenomics/MotifPeeker/commits/master)
<br> [![R build
status](https://github.com/neurogenomics/MotifPeeker/workflows/rworkflows/badge.svg)](https://github.com/neurogenomics/MotifPeeker/actions)
[![](https://codecov.io/gh/neurogenomics/MotifPeeker/branch/master/graph/badge.svg)](https://app.codecov.io/gh/neurogenomics/MotifPeeker)
<br>
<a href='https://app.codecov.io/gh/neurogenomics/MotifPeeker/tree/master' target='_blank'><img src='https://codecov.io/gh/neurogenomics/MotifPeeker/branch/master/graphs/icicle.svg' title='Codecov icicle graph' width='200' height='50' style='vertical-align: top;'></a>

**Authors:** ***Hiranyamaya (Hiru) Dash, Thomas Roberts, Nathan
Skene***  
**Updated:** ***Nov-05-2024***

## Introduction

`MotifPeeker` is used to compare and analyse datasets from epigenomic
profiling methods with motif enrichment as the key benchmark. The
package outputs an HTML report consisting of three sections:

1.  **General Metrics**: Provides an overview of metrics related to
    dataset peaks, including FRiP scores, peak widths, and
    motif-to-summit distances.

2.  **Known Motif Enrichment Analysis**: Presents statistics on the
    frequency of enriched user-supplied motifs in the datasets and
    compares them between the common and unique peaks from comparison
    and reference datasets.

3.  **De-Novo Motif Enrichment Analysis**: Details the statistics of
    de-novo discovered motifs in common and unique peaks from comparison
    and reference datasets. Examines motif similarities and identifies
    the closest known motifs in the JASPAR or the provided database.

<!-- If you use `MotifPeeker`, please cite:  -->

<!-- >  -->

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
the development version of `MotifPeeker` can be installed using the
following code:

``` r
if(!require("remotes")) install.packages("remotes")

remotes::install_github("neurogenomics/MotifPeeker")
library(MotifPeeker)
```

Alternatively, you can use the [Docker/Singularity
container](https://neurogenomics.github.io/MotifPeeker/articles/docker.html)
to run the package out-of-the-box.

## Documentation

#### [MotifPeeker Website](https://neurogenomics.github.io/MotifPeeker)

#### [Get Started](https://neurogenomics.github.io/MotifPeeker/articles/MotifPeeker.html)

#### [Docker/Singularity Container](https://neurogenomics.github.io/MotifPeeker/articles/docker.html)

#### [Example Reports](https://neurogenomics.github.io/MotifPeeker/articles/examples.html)

#### [Troubleshooting](https://neurogenomics.github.io/MotifPeeker/articles/troubleshooting.html)

## Usage

Load the package and example datasets.

``` r
library(MotifPeeker)
data("CTCF_ChIP_peaks", package = "MotifPeeker")
data("CTCF_TIP_peaks", package = "MotifPeeker")
data("motif_MA1102.2", package = "MotifPeeker")
data("motif_MA1930.2", package = "MotifPeeker")
```

Prepare input files.

``` r
peak_files <- list(CTCF_ChIP_peaks, CTCF_TIP_peaks)
alignment_files <- list(
    system.file("extdata", "CTCF_ChIP_alignment.bam", package = "MotifPeeker"),
    system.file("extdata", "CTCF_TIP_alignment.bam", package = "MotifPeeker")
)
motif_files <- list(motif_MA1102.2, motif_MA1930.2)
```

Run `MotifPeeker()`:

``` r
MotifPeeker(
    peak_files = peak_files,
    reference_index = 2,  # Set TIP-seq experiment as reference
    alignment_files = alignment_files,
    exp_labels = c("ChIP", "TIP"),
    exp_type = c("chipseq", "tipseq"),
    genome_build = "hg38",
    motif_files = motif_files,
    cell_counts = NULL,  # No cell-count information
    denovo_motif_discovery = TRUE,
    denovo_motifs = 3,
    motif_db = NULL,
    download_buttons = TRUE,
    out_dir = tempdir(),
    workers = 2,
    debug = FALSE,
    quiet = FALSE,
    verbose = TRUE
)
```

### Required Inputs

These input parameters must be provided:

<details>

<summary>

<strong>Details</strong>
</summary>

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

</details>

### Optional Inputs

These input parameters optional, but *recommended* to add more analyses,
or enhance them:

<details>

<summary>

<strong>Details</strong>
</summary>

- `alignment_files`: A list of path to alignment files or
  `Rsamtools::BamFile` objects with the alignment sequences to analyse.
  Alignment files are used to calculate read-related metrics like FRiP
  score. ENCODE file IDs can also be provided to automatically fetch
  alignment file(s) from the ENCODE database.  
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
  or a list of `universalmotif-class` objects. Results from de-novo
  motif discovery are searched against this database to find similar
  motifs. If not provided, JASPAR CORE database will be used, making
  this parameter **truly optional**. **NOTE**: p-value estimates are
  inaccurate when the database has fewer than 50 entries.

</details>

### Other Options

For more information on additional parameters, please refer to the
documentation for
[`MotifPeeker()`](https://neurogenomics.github.io/MotifPeeker/reference/MotifPeeker.html).

### Runtime Guidance

For 4 datasets, the runtime is approximately 3 minutes with
denovo_motif_discovery disabled. However, de-novo motif discovery can
take hours to complete.

To make computation faster, we highly recommend tuning the following
arguments:

<details>

<summary>

<strong>Details</strong>
</summary>

- `workers`: Running motif discovery in parallel can significantly
  reduce runtime, but it is very memory-intensive, consuming upwards of
  10GB of RAM per thread. Memory starvation can greatly slow the
  process, so set `workers` with caution.  
- `denovo_motifs`: The number of motifs to discover per sequence group
  exponentially increases runtime. We recommend no more than 5 motifs to
  make a meaningful inference.  
- `trim_seq_width`: Trimming sequences before running de-novo motif
  discovery can significantly reduce the search space. Sequence length
  can exponentially increase runtime. We recommend running the script
  with `denovo_motif_discovery = FALSE` and studying the motif-summit
  distance distribution under general metrics to find the sequence
  length that captures most motifs. A good starting point is 150 but it
  can be reduced further if appropriate.

</details>

### Outputs

`MotifPeeker` generates its output in a new folder within he `out_dir`
directory. The folder is named `MotifPeeker_YYYYMMDD_HHMMSS` and
contains the following files:

- `MotifPeeker.html`: The main HTML report, including all analyses and
  plots.  
- Output from various MEME suite tools in their respecive
  sub-directories, if `save_runfiles` is set to `TRUE`.

## Datasets

`MotifPeeker` comes with several datasets bundled:

<details>

<summary>

<strong>Details</strong>
</summary>

- `CTCF_TIP_peaks`: Human CTCF peak file generated with TIP-seq using
  HCT116 cell-line. No control files were used to generate the peak
  file. The peaks were called using `MACS3` with
  `CTCF_TIP_alignment.bam` as input.  
- `CTCF_ChIP_peaks`: Human CTCF peak file generated with ChIP-seq using
  HCT116 cell-line. No control files were used to generate the peak
  file. The peaks were called using `MACS3` with
  `CTCF_ChIP_alignment.bam` as input.  
- `motif_MA1102.3`: The JASPAR motif for CTCFL (MA1102.3) for *Homo
  Sapiens*. Sourced from
  [JASPAR](https://jaspar.elixir.no/matrix/MA1102.3/)
- `motif_MA1930.2`: The JASPAR motif for CTCFL (MA1930.2) for *Homo
  Sapiens*. Sourced from
  [JASPAR](https://jaspar.elixir.no/matrix/MA1930.2/)
- `CTCF_TIP_alignment.bam`: Human CTCF alignment file generated with
  TIP-seq using HCT116 cell-line. The alignment file was generated using
  the [`nf-core/cutandrun`](https://nf-co.re/cutandrun/3.2.2) pipeline.
  Raw read files were sourced from *NIH Sequence Read Archives* [*ID:
  SRR16963166*](https://trace.ncbi.nlm.nih.gov/Traces/index.html?view=run_browser&acc=SRR16963166).
  Only available as *extdata*.  
- `CTCF_ChIP_alignment.bam`: Human CTCF alignment file generated with
  ChIP-seq using HCT116 cell-line. Sourced from [ENCODE (Accession:
  ENCFF091ODJ)](https://www.encodeproject.org/files/ENCFF091ODJ/). Only
  available as *extdata*.

</details>

Please note that the peaks and alignments included are a very small
subset (*chr10:65,654,529-74,841,155*) of the actual data. It only
serves as an example to demonstrate the package and run tests to
maintain the integrity of the package.

## Licensing Restrictions

MotifPeeker incorporates the MEME Suite, which is available free of
charge for educational, research, and non-profit purposes. Users
intending to use MotifPeeker for commercial purposes are required to
purchase a license for the MEME Suite.

For more details, please refer to the [MEME Suite Copyright
Page](https://meme-suite.org/meme/doc/copyright.html).

## Contact

### [Neurogenomics Lab](https://www.neurogenomics.co.uk/inst/report/EpiCompare.html)

UK Dementia Research Institute  
Department of Brain Sciences  
Faculty of Medicine  
Imperial College London  
[GitHub](https://github.com/neurogenomics)

<hr>

### Session Info

<details>

``` r
utils::sessionInfo()
```

    ## R version 4.4.1 (2024-06-14)
    ## Platform: aarch64-apple-darwin20
    ## Running under: macOS 15.1
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
    ##  [1] gtable_0.3.6        jsonlite_1.8.9      renv_1.0.11        
    ##  [4] dplyr_1.1.4         compiler_4.4.1      BiocManager_1.30.25
    ##  [7] tidyselect_1.2.1    rvcheck_0.2.1       scales_1.3.0       
    ## [10] yaml_2.3.10         fastmap_1.2.0       here_1.0.1         
    ## [13] ggplot2_3.5.1       R6_2.5.1            generics_0.1.3     
    ## [16] knitr_1.48          yulab.utils_0.1.7   tibble_3.2.1       
    ## [19] desc_1.4.3          dlstats_0.1.7       rprojroot_2.0.4    
    ## [22] munsell_0.5.1       pillar_1.9.0        RColorBrewer_1.1-3 
    ## [25] rlang_1.1.4         utf8_1.2.4          badger_0.2.4       
    ## [28] xfun_0.49           fs_1.6.5            cli_3.6.3          
    ## [31] magrittr_2.0.3      rworkflows_1.0.2    digest_0.6.37      
    ## [34] grid_4.4.1          rstudioapi_0.17.1   lifecycle_1.0.4    
    ## [37] vctrs_0.6.5         evaluate_1.0.1      glue_1.8.0         
    ## [40] data.table_1.16.2   fansi_1.0.6         colorspace_2.1-1   
    ## [43] rmarkdown_2.29      tools_4.4.1         pkgconfig_2.0.3    
    ## [46] htmltools_0.5.8.1

</details>
