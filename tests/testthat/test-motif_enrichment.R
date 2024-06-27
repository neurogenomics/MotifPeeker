test_that("list outputted by motif_enrichment function", {
    data("CTCF_TIP_peaks", package = "MotifPeeker")
    data("motif_MA1102.3", package = "MotifPeeker")
    
    temp_dir <- withr::local_tempdir()
    withr::defer(temp_dir)
    
    res <- motif_enrichment(
        peak_input = CTCF_TIP_peaks,
        motif = motif_MA1102.3,
        genome_build = BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38,
        out_dir = temp_dir
    )
    expect_true(is.list(res))
})
