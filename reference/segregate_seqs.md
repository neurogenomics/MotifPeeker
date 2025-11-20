# Segregate input sequences into common and unique groups

This function takes two sets of sequences and segregates them into
common and unique sequences. The common sequences are sequences that are
present in both sets of sequences. The unique sequences are sequences
that are present in only one of the sets of sequences.

## Usage

``` r
segregate_seqs(seqs1, seqs2)
```

## Arguments

- seqs1:

  A set of sequences (`GRanges` object)

- seqs2:

  A set of sequences (`GRanges` object)

## Value

A list containing the common sequences and unique sequences for each set
of sequences. The list contains the following `GRanges` objects:

- `common_seqs1`: Common sequences in `seqs1`

- `common_seqs2`: Common sequences in `seqs2`

- `unique_seqs1`: Unique sequences in `seqs1`

- `unique_seqs2`: Unique sequences in `seqs2`

## Details

Sequences are considered common if their base pairs align in any
position, even if they vary in length. Consequently, while the number of
common sequences remains consistent between both sets, but the length
and composition of these sequences may differ. As a result, the function
returns distinct sets of common sequences for each input set of
sequences.

## See also

[findOverlaps](https://rdrr.io/pkg/IRanges/man/findOverlaps-methods.html)

## Examples

``` r
data("CTCF_ChIP_peaks", package = "MotifPeeker")
data("CTCF_TIP_peaks", package = "MotifPeeker")

seqs1 <- CTCF_ChIP_peaks
seqs2 <- CTCF_TIP_peaks
res <- segregate_seqs(seqs1, seqs2)
print(res)
#> $common_seqs1
#> GRanges object with 127 ranges and 7 metadata columns:
#>                    seqnames            ranges strand |             name
#>                       <Rle>         <IRanges>  <Rle> |      <character>
#>     ChIPseq_peak_3    chr10 66180787-66181041      * |   ChIPseq_peak_3
#>     ChIPseq_peak_6    chr10 66455384-66455636      * |   ChIPseq_peak_6
#>     ChIPseq_peak_7    chr10 66586154-66586345      * |   ChIPseq_peak_7
#>     ChIPseq_peak_8    chr10 66627231-66627517      * |   ChIPseq_peak_8
#>     ChIPseq_peak_9    chr10 66925870-66926137      * |   ChIPseq_peak_9
#>                ...      ...               ...    ... .              ...
#>   ChIPseq_peak_199    chr10 74081271-74081544      * | ChIPseq_peak_199
#>   ChIPseq_peak_200    chr10 74103609-74103897      * | ChIPseq_peak_200
#>   ChIPseq_peak_202    chr10 74153172-74153433      * | ChIPseq_peak_202
#>   ChIPseq_peak_206    chr10 74266052-74266297      * | ChIPseq_peak_206
#>   ChIPseq_peak_207    chr10 74419925-74420183      * | ChIPseq_peak_207
#>                        score signalValue    pValue    qValue      peak
#>                    <numeric>   <numeric> <numeric> <numeric> <integer>
#>     ChIPseq_peak_3       250     13.6027   28.6276   25.0595       117
#>     ChIPseq_peak_6       398     17.2191   43.6096   39.8530       112
#>     ChIPseq_peak_7       245     13.3070   28.1324   24.5738        86
#>     ChIPseq_peak_8       556     20.9281   59.6139   55.6729       146
#>     ChIPseq_peak_9       635     22.0495   67.6284   63.5924       131
#>                ...       ...         ...       ...       ...       ...
#>   ChIPseq_peak_199       956     26.9507  100.0720   95.6116       144
#>   ChIPseq_peak_200       335     15.2085   37.2591   33.5791       116
#>   ChIPseq_peak_202       430     16.4674   46.8334   43.0387       136
#>   ChIPseq_peak_206       613     21.7807   65.4013   61.3937       110
#>   ChIPseq_peak_207       457     18.4381   49.5552   45.7299       134
#>                       summit
#>                    <integer>
#>     ChIPseq_peak_3  66180904
#>     ChIPseq_peak_6  66455496
#>     ChIPseq_peak_7  66586240
#>     ChIPseq_peak_8  66627377
#>     ChIPseq_peak_9  66926001
#>                ...       ...
#>   ChIPseq_peak_199  74081415
#>   ChIPseq_peak_200  74103725
#>   ChIPseq_peak_202  74153308
#>   ChIPseq_peak_206  74266162
#>   ChIPseq_peak_207  74420059
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
#> 
#> $common_seqs2
#> GRanges object with 125 ranges and 7 metadata columns:
#>                   seqnames            ranges strand |            name     score
#>                      <Rle>         <IRanges>  <Rle> |     <character> <numeric>
#>     TIPseq_peak_1    chr10 66180800-66181033      * |   TIPseq_peak_1        73
#>     TIPseq_peak_2    chr10 66455342-66455626      * |   TIPseq_peak_2        99
#>     TIPseq_peak_3    chr10 66586093-66586239      * |   TIPseq_peak_3        63
#>     TIPseq_peak_4    chr10 66627203-66627536      * |   TIPseq_peak_4       122
#>     TIPseq_peak_5    chr10 66925844-66926200      * |   TIPseq_peak_5       234
#>               ...      ...               ...    ... .             ...       ...
#>   TIPseq_peak_171    chr10 74081300-74081610      * | TIPseq_peak_171        44
#>   TIPseq_peak_172    chr10 74103638-74103872      * | TIPseq_peak_172        75
#>   TIPseq_peak_174    chr10 74153189-74153455      * | TIPseq_peak_174       100
#>   TIPseq_peak_180    chr10 74265994-74266358      * | TIPseq_peak_180       142
#>   TIPseq_peak_181    chr10 74419929-74420132      * | TIPseq_peak_181       101
#>                   signalValue    pValue    qValue      peak    summit
#>                     <numeric> <numeric> <numeric> <integer> <integer>
#>     TIPseq_peak_1     7.26312  10.98040   7.31252        50  66180850
#>     TIPseq_peak_2     8.68181  13.84590   9.92037       142  66455484
#>     TIPseq_peak_3     6.18211   9.90174   6.32942        80  66586173
#>     TIPseq_peak_4     9.80905  16.47740  12.27160       114  66627317
#>     TIPseq_peak_5    14.14660  28.95280  23.43290       174  66926018
#>               ...         ...       ...       ...       ...       ...
#>   TIPseq_peak_171     5.66751   7.86457   4.47255       134  74081434
#>   TIPseq_peak_172     7.39208  11.22360   7.53561       121  74103759
#>   TIPseq_peak_174     7.91950  14.01050  10.06950        65  74153254
#>   TIPseq_peak_180    10.25590  18.75230  14.29350       180  74266174
#>   TIPseq_peak_181     8.69840  14.05790  10.11420        58  74419987
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
#> 
#> $unique_seqs1
#> GRanges object with 82 ranges and 7 metadata columns:
#>                    seqnames            ranges strand |             name
#>                       <Rle>         <IRanges>  <Rle> |      <character>
#>     ChIPseq_peak_1    chr10 65672891-65673094      * |   ChIPseq_peak_1
#>     ChIPseq_peak_2    chr10 66112133-66112279      * |   ChIPseq_peak_2
#>     ChIPseq_peak_4    chr10 66215124-66215282      * |   ChIPseq_peak_4
#>     ChIPseq_peak_5    chr10 66277566-66277829      * |   ChIPseq_peak_5
#>    ChIPseq_peak_12    chr10 67476285-67476431      * |  ChIPseq_peak_12
#>                ...      ...               ...    ... .              ...
#>   ChIPseq_peak_203    chr10 74213629-74213890      * | ChIPseq_peak_203
#>   ChIPseq_peak_204    chr10 74234663-74234817      * | ChIPseq_peak_204
#>   ChIPseq_peak_205    chr10 74244202-74244399      * | ChIPseq_peak_205
#>   ChIPseq_peak_208    chr10 74738977-74739145      * | ChIPseq_peak_208
#>   ChIPseq_peak_209    chr10 74826600-74826822      * | ChIPseq_peak_209
#>                        score signalValue    pValue    qValue      peak
#>                    <numeric>   <numeric> <numeric> <numeric> <integer>
#>     ChIPseq_peak_1       132     9.71581  16.61240  13.21760        91
#>     ChIPseq_peak_2        47     5.72046   7.95781   4.74195        77
#>     ChIPseq_peak_4        98     7.90847  13.19130   9.85816        52
#>     ChIPseq_peak_5       343    16.08460  38.04630  34.35700       126
#>    ChIPseq_peak_12        71     6.85832  10.48160   7.19900        76
#>                ...       ...         ...       ...       ...       ...
#>   ChIPseq_peak_203       776    25.89270  81.79150  77.60160       120
#>   ChIPseq_peak_204        73     6.97553  10.67840   7.39263        80
#>   ChIPseq_peak_205       144     9.44644  17.88500  14.46760        91
#>   ChIPseq_peak_208        66     6.52919   9.93714   6.66903        96
#>   ChIPseq_peak_209       192    11.78170  22.77100  19.28080       112
#>                       summit
#>                    <integer>
#>     ChIPseq_peak_1  65672982
#>     ChIPseq_peak_2  66112210
#>     ChIPseq_peak_4  66215176
#>     ChIPseq_peak_5  66277692
#>    ChIPseq_peak_12  67476361
#>                ...       ...
#>   ChIPseq_peak_203  74213749
#>   ChIPseq_peak_204  74234743
#>   ChIPseq_peak_205  74244293
#>   ChIPseq_peak_208  74739073
#>   ChIPseq_peak_209  74826712
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
#> 
#> $unique_seqs2
#> GRanges object with 57 ranges and 7 metadata columns:
#>                   seqnames            ranges strand |            name     score
#>                      <Rle>         <IRanges>  <Rle> |     <character> <numeric>
#>     TIPseq_peak_7    chr10 67284781-67284927      * |   TIPseq_peak_7        42
#>    TIPseq_peak_10    chr10 67531067-67531356      * |  TIPseq_peak_10        59
#>    TIPseq_peak_13    chr10 67779549-67779763      * |  TIPseq_peak_13        48
#>    TIPseq_peak_16    chr10 67838030-67838183      * |  TIPseq_peak_16        34
#>    TIPseq_peak_17    chr10 67849319-67849603      * |  TIPseq_peak_17        83
#>               ...      ...               ...    ... .             ...       ...
#>   TIPseq_peak_176    chr10 74190108-74190333      * | TIPseq_peak_176        82
#>   TIPseq_peak_177    chr10 74224190-74224510      * | TIPseq_peak_177        78
#>   TIPseq_peak_178    chr10 74231494-74231667      * | TIPseq_peak_178        78
#>   TIPseq_peak_179    chr10 74243885-74244038      * | TIPseq_peak_179        64
#>   TIPseq_peak_182    chr10 74826265-74826421      * | TIPseq_peak_182        45
#>                   signalValue    pValue    qValue      peak    summit
#>                     <numeric> <numeric> <numeric> <integer> <integer>
#>     TIPseq_peak_7     5.16484   7.66518   4.29365        42  67284823
#>    TIPseq_peak_10     6.40051   9.51973   5.98156        84  67531151
#>    TIPseq_peak_13     5.32656   8.31207   4.88917        74  67779623
#>    TIPseq_peak_16     4.47387   6.76965   3.47941       125  67838155
#>    TIPseq_peak_17     7.77252  12.07180   8.32041       104  67849423
#>               ...         ...       ...       ...       ...       ...
#>   TIPseq_peak_176     7.72798  11.99220   8.24690       144  74190252
#>   TIPseq_peak_177     7.30707  11.51720   7.81021       128  74224318
#>   TIPseq_peak_178     7.55650  11.53680   7.82873       111  74231605
#>   TIPseq_peak_179     6.73978  10.04360   6.45615        47  74243932
#>   TIPseq_peak_182     5.72697   7.96895   4.56751        20  74826285
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
#> 
```
