skip_if_not(memes::meme_is_installed(), "MEME is not installed")

test_that("enrichment plotting and datatable functions works", {
    ### Prepare input ###
    data("CTCF_ChIP_peaks", package = "MotifPeeker")
    data("CTCF_TIP_peaks", package = "MotifPeeker")
    data("motif_MA1102.3", package = "MotifPeeker")
    data("motif_MA1930.2", package = "MotifPeeker")
    input <- list(
        peaks = list(CTCF_ChIP_peaks, CTCF_TIP_peaks),
        exp_type = c("ChIP", "TIP"),
        exp_labels = c("CTCF_ChIP", "CTCF_TIP"),
        read_count = c(150, 200),
        peak_count = c(100, 120)
    )
    segregated_input <- segregate_seqs(input$peaks[[1]], input$peaks[[2]])
    motifs <- list(
        motifs = list(motif_MA1930.2, motif_MA1102.3),
        motif_labels = list("MA1930.2", "MA1102.3")
    )
    reference_index <- 1
    genome_build <- BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
    
    enrichment_df <- get_df_enrichment(
        input, segregated_input, motifs, genome_build, reference_index = 1,
        workers = 1
    )
    
    label_colours <- c("red", "cyan")
    
    ### Test plot_enrichment_individual ###
    ## Same reference index and comparison index
    plot_enrichment_individual(input, enrichment_df, 1, 1, label_colours) %>%
        expect_error()
    
    plt_individual <- plot_enrichment_individual(
            input, enrichment_df, comparison_i = 2, motif_i = 1,
            label_colours = label_colours, reference_index = 1
        )
    expect_true(inherits(plt_individual, "shiny.tag.list"))
    
    ### Test plot_enrichment_overall ###
    plt_overall <- plot_enrichment_overall(
        enrichment_df, motif_i = 1, label_colours = label_colours,
        reference_label = "CTCF_ChIP"
    )
    expect_length(plt_overall, 2)
    expect_true(all(sapply(plt_overall, inherits, "shiny.tag.list")))
    
    ### Test dt_enrichment_individual ###
    dt <- dt_enrichment_individual(
        input, enrichment_df, comparison_i = 2, motif_i = 1, reference_index = 1
    )
    expect_true(inherits(dt, "shiny.tag.list"))
})
