test_that("bpapply works", {
    test_func <- function(arg1, arg2 = NULL) {
        if (is.null(arg2)) return(arg1)
        return(arg1 + arg2)
    }
    
    x <- y <- seq_len(10)
    
    ### Non-existent apply_fun ###
    expect_error(bpapply(x, test_func, apply_fun = "does_not_exist"))
    
    ### bplapply ###
    res <- bpapply(x, test_func, workers = 2)
    expect_equal(unlist(res), x)
    
    ### SnowParam ###
    res <- bpapply(x, test_func, workers = 1, force_snowparam = TRUE,
                   progressbar = FALSE)
    expect_equal(unlist(res), x)
    
    ### bpmapply ###
    res <- bpapply(x, test_func, apply_fun = BiocParallel::bpmapply,
                    workers = 2, MoreArgs = list(arg2 = y),
                    progressbar = FALSE)
    expect_equal(res[1,2], 3)
})
