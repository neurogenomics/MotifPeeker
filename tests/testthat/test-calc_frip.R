test_that("calc_frip works", {
    read_file <- system.file("extdata", "CTCF_ChIP_alignment.bam",
                            package = "MotifPeeker")
    read_file <- Rsamtools::BamFile(read_file)
    data("CTCF_ChIP_peaks", package = "MotifPeeker")
    score <- calc_frip(read_file, CTCF_ChIP_peaks)
    expect_true(0.5 > score & score > 0.05)
})
