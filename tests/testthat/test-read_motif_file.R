test_that("read_motif_file can read jaspar motif file", {
    motif_file <- system.file("extdata", "motif_MA1930.2.jaspar",
                              package = "MotifPeeker")
    motif <- check_input(motif_file, "motif", read_motif_file, inverse = TRUE,
                        file_format = "jaspar")
    expect_s4_class(motif, "universalmotif")
})
test_that("read_motif_file can infer motif file-format", {
    motif_file <- system.file("extdata", "motif_MA1930.2.jaspar",
                              package = "MotifPeeker")
    motif <- read_motif_file(motif_file)
    expect_s4_class(motif, "universalmotif")
})
test_that("read_motif_file can take universalmotif object", {
    motif_file <- system.file("extdata", "motif_MA1930.2.jaspar",
                              package = "MotifPeeker")
    motif <- read_motif_file(motif_file, file_format = "jaspar")
    motif2 <- read_motif_file(motif)
    expect_identical(motif, motif2)
})
test_that("read_motif_file fails with invalid data", {
    motif_file <- system.file("extdata","CTCF_ChIP_peaks.narrowPeak",
                              package = "MotifPeeker")
    expect_error(read_motif_file(motif_file))
    
    read_file <- read_peak_file(motif_file)
    expect_error(read_motif_file(read_file))
})
