test_that("read_motif_file() can read jaspar motif file", {
    motif_file <- system.file("extdata",
                              "motif_MA1930.2.jaspar",
                              package = "MotifPeeker")
    motif <- read_motif_file(motif_file,
                             motif_id = "MA1930.2",
                             file_format = "jaspar")
    expect_s4_class(motif, "universalmotif")
})
