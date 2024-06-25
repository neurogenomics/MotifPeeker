test_that("get_JASPARCORE works", {
    core_path <- get_JASPARCORE()
    expect_true(grepl("CORE_non-redundant_pfms_meme", core_path))
})
