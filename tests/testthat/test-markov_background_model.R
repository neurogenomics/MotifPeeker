test_that("file created by markov_background_model function", {
    temp_dir <- withr::local_tempdir()
    
    data("CTCF_TIP_peaks", package = "MotifPeeker")
    genome_build <- BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
    peak_sequences <- BSgenome::getSeq(genome_build,
                                       CTCF_TIP_peaks)
    
    res <- markov_background_model(sequences = peak_sequences,
                                   out_dir = temp_dir)
    
    expect_true(file.exists(file.path(temp_dir, "background_model.txt")))
})
