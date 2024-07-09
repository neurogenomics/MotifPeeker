test_that("normalise_paths works", {
    expect_null(normalise_paths(NULL))
    
    ## Return non-character items as-is
    data("CTCF_ChIP_peaks", package = "MotifPeeker")
    expect_equal(normalise_paths(CTCF_ChIP_peaks)[[1]], CTCF_ChIP_peaks)
    
    ## Return full paths from relative paths
    file <- system.file("extdata", "CTCF_ChIP_alignment.bam",
                        package = "MotifPeeker")
    expect_equal(normalise_paths(file)[[1]], file)
})
