test_that("read_peak_file can read SEACR peak file", {
    seacr_peak_file <- system.file("extdata", "SRR16963165_SEACR.stringent.bed",
                                   package = "MotifPeeker")
    seacr_peak_read <- read_peak_file(seacr_peak_file, file_format = "bed")
    expect_length(seacr_peak_read, 1581)
})
test_that("read_peak_file can read MACS3 peak file and auto-infer format", {
    macs3_peak_file <- system.file("extdata", "CTCF_ChIP_peaks.narrowPeak",
                                   package = "MotifPeeker")
    macs3_peak_read <- read_peak_file(macs3_peak_file)
    expect_length(macs3_peak_read, 209)
})
test_that("read_peak_file fails with unknown file format forced", {
    invalid_peak_file <- system.file("extdata", "motif_MA1102.3.jaspar",
                                   package = "MotifPeeker")
    expect_error(read_peak_file(invalid_peak_file, file_format = "narrowPeak"))
    expect_error(read_peak_file(invalid_peak_file, file_format = "bed"))
    expect_error(read_peak_file(invalid_peak_file))
})
