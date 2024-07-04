test_that("De-novo motif enrichment functions works", {
    data("CTCF_TIP_peaks", package = "MotifPeeker")
    data("CTCF_ChIP_peaks", package = "MotifPeeker")
    genome_build <- BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
    
    segregated_peaks <- segregate_seqs(CTCF_TIP_peaks, CTCF_ChIP_peaks)
    
    ### denovo_motifs and filter_repeats ###
    res <- denovo_motifs(unlist(segregated_peaks),
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
    
    ### find_motifs ###
    motif_db <- get_JASPARCORE()
    res2 <- find_motifs(res,
                        motif_db = motif_db,
                        workers = 1,
                        verbose = FALSE,
                        debug = FALSE)
    expect_equal(res2[[1]][[1]]$motif[[1]]@alphabet, "DNA")
    
    ### compare_motifs ###
    res3 <- compare_motifs(res,
                            workers = 1,
                            verbose = FALSE)
    expect_true(all(vapply(res3, is.matrix, logical(1))))
})
