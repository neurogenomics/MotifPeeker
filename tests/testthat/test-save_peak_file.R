test_that("save_peak_file works", {
    data("CTCF_ChIP_peaks", package = "MotifPeeker")
    
    out <- save_peak_file(CTCF_ChIP_peaks, TRUE, "test_peak_file")
    read_out <- utils::read.table(out, header = FALSE, sep = "\t")
    
    expect_length(read_out, 4)
    expect_equal(nrow(read_out), length(CTCF_ChIP_peaks))
    expect_warning(save_peak_file(CTCF_ChIP_peaks, TRUE,
                                    "test_peak_file.narrowPeak"))
    
    out2 <- save_peak_file(CTCF_ChIP_peaks, FALSE)
    expect_true(is.data.frame(out2))
})
