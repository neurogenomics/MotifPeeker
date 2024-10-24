test_that("messager works", {
    
    msg <- "Hello world"
    #### Parallel = FALSE ####
    msg_out <- utils::capture.output(messager(msg),
                                    type = "message")
    testthat::expect_equal(msg, msg_out)
})
