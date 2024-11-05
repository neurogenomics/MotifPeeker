skip_if_offline()

test_that("check_JASPAR works", {
    expect_error(check_JASPAR("/a/path.jaspar"))
    
    motif <- check_JASPAR("MA1930.2")
    expect_true(grepl("MA1930.2.jaspar", motif))
    
    ## check_input
    expect_equal(check_input("/a/path.jaspar", "jaspar_id", check_JASPAR),
                "/a/path.jaspar")
})
