test_that("download_button works", {
    data("CTCF_ChIP_peaks", package = "MotifPeeker")
    out <- save_peak_file(CTCF_ChIP_peaks, TRUE, "test_peak_file")
    
    btn <- download_button(out,
                            type = "file",
                            button_label = "Download Peaks")
    expect_true(grepl("button", btn))
})
