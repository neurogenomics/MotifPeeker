test_that("check_ENCODE works", {
    expect_equal(check_ENCODE("/a/path"), "/a/path")
    
    valid_file <- check_ENCODE("ENCFF920TXI", expect_format = c("bed", "gz"))
    expect_true(grepl("ENCFF920TXI.bed.gz", valid_file))
    
    expect_error(check_ENCODE("ENCFF920TXI", expect_format = c("bed")))
    
    ## Not a file
    expect_error(check_ENCODE("ENCSR398OAO", expect_format = c("bam", "bed",
                                                               "gz")))
})
