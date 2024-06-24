test_that("format_exptype works", {
    expect_equal(format_exptype("chipseq"), "ChIP-Seq")
    expect_equal(format_exptype(NA), "Unknown")
    expect_equal(format_exptype("customseq"), "customseq")
})
