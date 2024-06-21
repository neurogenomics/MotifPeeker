# Peaks were called using MACS3 with the following command:
# macs3 callpeak -t CTCF_ChIP_alignment.bam -n ChIPseq -g hs -q 0.01 \
# --nomodel --extsize 147 --outdir ./output
#
# NOTE: --nomodel was used since the number of reads in the subset file was too
# low to generate a model. The --extsize parameter was set to 147 based on the
# fragment size estimated from the full dataset.
