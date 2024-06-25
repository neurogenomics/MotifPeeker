test_that("check_JASPAR works", {
    expect_equal(check_JASPAR("/a/path.jaspar"), "/a/path.jaspar")
    
    motif <- check_JASPAR("MA1930.2")
    expect_true(grepl("MA1930.2.jaspar", motif))
})
