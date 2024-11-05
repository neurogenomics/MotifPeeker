skip_if_not(memes::meme_is_installed(), "MEME is not installed")

test_that("De-novo motif enrichment functions works", {
    data("CTCF_TIP_peaks", package = "MotifPeeker")
    data("CTCF_ChIP_peaks", package = "MotifPeeker")
    genome_build <- BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
    
    segregated_peaks <- segregate_seqs(CTCF_TIP_peaks, CTCF_ChIP_peaks)
    
    ### denovo_motifs and filter_repeats ###
    res <- suppressMessages(denovo_motifs(unlist(segregated_peaks),
                        trim_seq_width = 100,
                        genome_build = genome_build,
                        denovo_motifs = 2,
                        filter_n = 6,
                        out_dir = tempdir(),
                        verbose = FALSE,
                        debug = FALSE))
    
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
                        verbose = TRUE,
                        debug = TRUE)
    expect_length(res2, 4)
    expect_equal(res2[[1]][[1]]$motif[[1]]@alphabet, "DNA")

    ## motif_similarity ###
    res3 <- motif_similarity(res)
    expect_true(all(vapply(res3, is.matrix, logical(1))))

    ### plot_motif_comparison ###
    res4 <- plot_motif_comparison(res3, c("reference", "comparison"),
                                html_tags = TRUE)
    expect_true(all(vapply(res4, function(x) inherits(x, "shiny.tag.list"),
                            logical(1))))
    
    ### get_download_buttons ###
    ## Create dummy directories
    out_dir <- file.path(tempdir(), "denovo_motif_func_test")
    streme_out <- file.path(out_dir, "streme")
    tomtom_out <- file.path(out_dir, "tomtom")
    for (i in seq_len(4)) {
        if (!dir.exists(file.path(streme_out, i))) {
            dir.create(file.path(streme_out, i), recursive = TRUE)
        }
        if (!dir.exists(file.path(tomtom_out, i))) {
            dir.create(file.path(tomtom_out, i), recursive = TRUE)
        }
    }
    res5 <- get_download_buttons(1, 1, list(segregated_peaks), out_dir)
    expect_type(res5, "list")

    ### print_denovo_sections ###
    section_out <- print_denovo_sections(res, res2, segregated_peaks, c(1,2),
                            jaspar_link = TRUE, download_buttons = res5)
    expect_type(section_out, "list")
})
