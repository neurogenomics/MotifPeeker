# Check genome build

Check if the genome build is valid and return an appropriate
[BSgenome-class](https://rdrr.io/pkg/BSgenome/man/BSgenome-class.html)
object.

## Usage

``` r
check_genome_build(genome_build)
```

## Arguments

- genome_build:

  A character string with the abbreviated genome build name, or a
  BSGenome object. Check check_genome_build details for genome builds
  which can be imported as abbreviated names.

## Value

A BSGenome object.

## Details

Currently, the following genome builds can be specified to
\`genome_build\` as abbreviated names:

- `hg38`: Human genome build GRCh38 (BSgenome.Hsapiens.UCSC.hg38)

- `hg19`: Human genome build GRCh37 (BSgenome.Hsapiens.UCSC.hg19)

- `mm10`: Mouse genome build GRCm38 (BSgenome.Mmusculus.UCSC.mm10)

- `mm39`: Mouse genome build GRCm39 (BSgenome.Mmusculus.UCSC.mm39)

If the genome build you wish to use is not listed here, please pass a
[BSgenome-class](https://rdrr.io/pkg/BSgenome/man/BSgenome-class.html)
data object directly.

## See also

[BSgenome-class](https://rdrr.io/pkg/BSgenome/man/BSgenome-class.html)
for more information on BSGenome objects.

## Examples

``` r
if (requireNamespace("BSgenome.Hsapiens.UCSC.hg38", quietly = TRUE)) {
    check_genome_build("hg38")
}
#> | BSgenome object for Human
#> | - organism: Homo sapiens
#> | - provider: UCSC
#> | - genome: hg38
#> | - release date: 2023/01/31
#> | - 711 sequence(s):
#> |     chr1                    chr2                    chr3                   
#> |     chr4                    chr5                    chr6                   
#> |     chr7                    chr8                    chr9                   
#> |     chr10                   chr11                   chr12                  
#> |     chr13                   chr14                   chr15                  
#> |     ...                     ...                     ...                    
#> |     chr19_KV575256v1_alt    chr19_KV575257v1_alt    chr19_KV575258v1_alt   
#> |     chr19_KV575259v1_alt    chr19_KV575260v1_alt    chr19_MU273387v1_alt   
#> |     chr22_KN196485v1_alt    chr22_KN196486v1_alt    chr22_KQ458387v1_alt   
#> |     chr22_KQ458388v1_alt    chr22_KQ759761v1_alt    chrX_KV766199v1_alt    
#> |     chrX_MU273395v1_alt     chrX_MU273396v1_alt     chrX_MU273397v1_alt    
#> | 
#> | Tips: call 'seqnames()' on the object to get all the sequence names, call
#> | 'seqinfo()' to get the full sequence info, use the '$' or '[[' operator to
#> | access a given sequence, see '?BSgenome' for more information.
```
