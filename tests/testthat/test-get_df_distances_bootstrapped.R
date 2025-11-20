skip_if_not(memes::meme_is_installed(), "MEME is not installed")

test_that("Bootstrapping meta function works", {
    peak <- system.file("extdata", "CTCF_ChIP_peaks.narrowPeak",
                        package = "MotifPeeker") |>
        read_peak_file() |>
        sample(20)
    motif_MA1930.2 <- system.file("extdata", "motif_MA1930.2.jaspar",
                                  package = "MotifPeeker") |> read_motif_file()
    motif_MA1102.3 <- system.file("extdata", "motif_MA1102.3.jaspar",
                         package = "MotifPeeker") |> read_motif_file()
    genome_build <- BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
    
    input <- list(
        peaks = peak,
        exp_type = "ChIP",
        exp_labels = "CTCF",
        read_count = 150,
        peak_count = 100
    )
    motifs <- list(
        motifs = list(motif_MA1930.2, motif_MA1102.3),
        motif_labels = list("MA1930.2", "MA1102.3")
    )
    
    distances_df_bootstrapped <- get_df_distances_bootstrapped(
        input,
        user_motifs = motifs,
        genome_build = genome_build,
        samples_n = NULL,
        samples_len = NULL,
        verbose = FALSE
    )
    
    expect_true(is.data.frame(distances_df_bootstrapped))
    expect_true(all(c(1, 2) %in% unique(distances_df_bootstrapped$motif_indice)))
    expect_true(all(distances_df_bootstrapped$distance[!is.na(distances_df_bootstrapped$distance)] >= 0))
})
