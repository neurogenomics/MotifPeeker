test_that("denovo_motifs and filter_repeats works", {
    data("CTCF_TIP_peaks", package = "MotifPeeker")
    genome_build <- BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
    
    res <- denovo_motifs(list(CTCF_TIP_peaks),
                        trim_seq_width = 100,
                        genome_build = genome_build,
                        denovo_motifs = 2,
                        filter_n = 6,
                        out_dir = tempdir(),
                        workers = 1,
                        verbose = FALSE,
                        debug = FALSE)
    
    expect_length(res[[1]]$consensus, 2)
    expect_warning(denovo_motifs(list(CTCF_TIP_peaks),
                                trim_seq_width = 100,
                                genome_build = genome_build,
                                denovo_motifs = 1,
                                filter_n = 2))
})
