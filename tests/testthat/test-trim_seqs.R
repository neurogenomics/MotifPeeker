test_that("trim_seqs works", {
    data("CTCF_TIP_peaks", package = "MotifPeeker")
    peaks <- CTCF_TIP_peaks
    genome_build <- BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
    
    trimmed_seqs <- trim_seqs(peaks, peak_width = 100,
                                genome_build = genome_build,
                                respect_bounds = FALSE)
    expect_true(all(GenomicRanges::width(trimmed_seqs) <= 101))
    
    trimmed_seqs_bound <- trim_seqs(peaks, peak_width = 1000,
                                    genome_build = genome_build,
                                    respect_bounds = TRUE)
    expect_true(all(GenomicRanges::width(trimmed_seqs_bound) <= 
                        max(GenomicRanges::width(peaks)) + 1))
})
