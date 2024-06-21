# Raw read files sourced from NIH Sequence Read Archives (ID: SRR16963166)
# https://trace.ncbi.nlm.nih.gov/Traces/index.html?view=run_browser&acc=SRR16963166
#
# Alignment file produced using nf-core/cutandrun pipeline run with the
# following parameters:
# nextflow run nf-core/cutandrun \
# -r 3.2.2 \
# --input $input \
# --outdir $outdir \
# -c $config \
# --genome GRCh38 \
# --igenomes_base $reference_genome \
# --blacklist ENCFF356LFX_blacklist.bed \
# --remove_linear_duplicates true \
# --dedup_target_reads true \
# --remove_mitochondrial_reads true \
# --end_to_end true \
# --use_control false \
# --normalisation_mode None \
# --minimum_alignment_q_score 10 \
# --peakcaller seacr,macs2 \
# --seacr_norm non \
# --macs2_narrow_peak true \
# --macs2_qvalue 0.01 \
# --seacr_peak_threshold 0.05 \
# --seacr_stringent stringent \
# --only_filtering false
# 
# First-mate reads were then filtered out using the following command:
# bamtools filter \
# -in SRR16963166_R1.target.linear_dedup.sorted.bam \
# -out SRR16963166_R1.target.linear_dedup.sorted_firstmate.bam \
# -isFirstMate true
#
# Subset of the data (chr10:65,654,529-74,841,155) was produced using the
# following command:
# samtools view -b SRR16963166_R1.target.linear_dedup.sorted_firstmate.bam \
# chr10:65,654,529-74,841,155 > CTCF_TIP_alignment.bam
