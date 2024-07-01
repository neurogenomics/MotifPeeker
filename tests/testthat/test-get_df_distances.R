test_that("get_df_distances works", {
    data("CTCF_ChIP_peaks", package = "MotifPeeker")
    data("motif_MA1102.3", package = "MotifPeeker")
    data("motif_MA1930.2", package = "MotifPeeker")
    input <- list(
        peaks = CTCF_ChIP_peaks,
        exp_type = "ChIP",
        exp_labels = "CTCF",
        read_count = 150,
        peak_count = 100
    )
    motifs <- list(
        motifs = list(motif_MA1930.2, motif_MA1102.3),
        motif_labels = list("MA1930.2", "MA1102.3")
    )
    genome_build <- BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
    
    distances_df <- get_df_distances(input, motifs, genome_build, workers = 1)
    
    expect_true(is.data.frame(distances_df))
    expect_true(all(vapply(distances_df$distance, is.numeric, logical(1))))
})
