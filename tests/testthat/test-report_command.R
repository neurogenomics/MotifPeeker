test_that("report_command works", {
    params <- list(
        peak_files = list("test", "test2"),
        reference_index = 1,
        alignment_files = NULL,
        exp_labels = c("A", "B", "C"),
        exp_type = NULL,
        genome_build = NULL,
        motif_files = NULL,
        motif_labels = NULL,
        cell_counts = NULL,
        denovo_motif_discovery = NULL,
        denovo_motifs = 3,
        motif_db = NULL,
        download_buttons = NULL,
        output_dir = NULL,
        use_cache = NULL,
        ncpus = NULL,
        debug = FALSE,
        verbose = TRUE
    )
    cmd <- report_command(params)
    expect_true(grepl("MotifPeeker\\(", cmd))
})
