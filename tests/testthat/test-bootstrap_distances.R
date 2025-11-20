skip_if_not(memes::meme_is_installed(), "MEME is not installed")

test_that("Bootstrapping motif-summit distances work", {
    peak <- system.file("extdata", "CTCF_ChIP_peaks.narrowPeak",
                        package = "MotifPeeker") |>
        read_peak_file() |>
        sample(10)
    motif <- system.file("extdata", "motif_MA1102.3.jaspar",
                         package = "MotifPeeker") |> read_motif_file()
    genome_build <- BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38

    distances <- bootstrap_distances(
        peak = peak,
        motif = motif,
        genome_build = genome_build,
        samples_n = NULL,
        samples_len = NULL,
        verbose = FALSE
    )

    expect_true(is.numeric(distances))
    expect_true(all(distances[!is.na(distances)] >= 0))

    # Try with excessive samples_len
    expect_error(
        bootstrap_distances(
            peak = peak,
            motif = motif,
            genome_build = genome_build,
            samples_n = 5,
            samples_len = length(peak) + 10,
            verbose = FALSE
        )
    )
})
