test_that("list outputted by summit_to_motif function", {
    temp_dir <- withr::local_tempdir()
    
    data("CTCF_TIP_peaks", package = "MotifPeeker")
    data("motif_MA1102.3", package = "MotifPeeker")
    
    res <- summit_to_motif(
        peak_input = CTCF_TIP_peaks,
        motif = motif_MA1102.3,
        fp_rate = 5e-02,
        genome_build = BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38,
        out_dir = temp_dir
    )
    expect_true(is.list(res))
})
