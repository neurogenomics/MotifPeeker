test_that("seggregate_seqs work", {
    data("CTCF_ChIP_peaks", package = "MotifPeeker")
    data("CTCF_TIP_peaks", package = "MotifPeeker")
    
    seqs1 <- CTCF_ChIP_peaks
    seqs2 <- CTCF_TIP_peaks
    res <- segregate_seqs(seqs1, seqs2)
    common_overlaps <- GenomicRanges::findOverlaps(res$common_seqs1,
                                                    res$common_seqs2,
                                                    type = "any")
    unique_overlaps <- GenomicRanges::findOverlaps(res$unique_seqs1,
                                                   res$unique_seqs2,
                                                   type = "any")
    
    expect_equal(length(S4Vectors::queryHits(common_overlaps)),
                 length(S4Vectors::subjectHits(common_overlaps)))
    expect_equal(length(S4Vectors::queryHits(unique_overlaps)), 0)
    expect_equal(length(S4Vectors::subjectHits(unique_overlaps)), 0)
})
