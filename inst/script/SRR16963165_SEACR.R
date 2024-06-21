# The SEACR BED file is only bundled to test the package's read_peak_file()
# function.
#
# The sample file was generated on an irrelevant alignment file using the
# following commands:
# sample=SRR16963165
# bedtools bamtobed -bed -i $sample.bam > $sample.bed
# awk '$1==$4 && $6-$2 < 1000 {print $0}' $sample.bed > $sample.clean.bed
# cut -f 1,2,6 $sample.clean.bed | sort -k1,1 \
# -k2,2n -k3,3n > $sample.fragments.bed
# bedtools genomecov -bg -i $sample.fragments.bed \
# -g hg38.chrom.sizes > $sample.fragments.bedgraph
# ./SEACR_1.3.sh $sample.fragments.bedgraph 0.01 norm stringent $sample
