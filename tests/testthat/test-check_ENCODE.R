skip_if_offline()

test_that("check_ENCODE works", {
    expect_error(check_ENCODE("/a/path"))
    
    valid_file <- check_ENCODE("ENCFF920TXI", expect_format = c("bed", "gz"))
    expect_true(grepl("ENCFF920TXI.bed.gz", valid_file))
    
    expect_error(check_ENCODE("ENCFF920TXI", expect_format = c("bed")))
    
    ## Not a file
    expect_error(check_ENCODE("ENCSR398OAO", expect_format = c("bam", "bed",
                                                               "gz")))
    
    ## check_input
    expect_equal(check_input("/a/path", "encode_id", check_ENCODE), "/a/path")
    valid_file2 <- check_input("ENCFF920TXI", "encode_id", check_ENCODE, 
                               expect_format = c("bed", "gz"))
    expect_true(grepl("ENCFF920TXI.bed.gz", valid_file2))
})
