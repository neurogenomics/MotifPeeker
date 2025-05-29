test_that("messager works", {
    
    msg <- "Hello world"
    #### Parallel = FALSE ####
    expect_no_error(messager(msg))
    
    result <- messager(msg)
    expect_true(is.null(result) || !is.na(result))
})
