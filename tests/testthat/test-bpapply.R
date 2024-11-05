test_that("bpapply works", {
    test_func <- function(arg1, arg2 = NULL) {
        if (is.null(arg2)) return(arg1)
        return(arg1 + arg2)
    }
    
    x <- y <- seq_len(10)
    
    ### Non-existent apply_fun ###
    expect_error(MotifPeeker:::bpapply(x, test_func,
                                       apply_fun = "does_not_exist"))
    
    ### bplapply ###
    res <- MotifPeeker:::bpapply(x, test_func)
    expect_equal(unlist(res), x)
    
    ### bpmapply ###
    res <- MotifPeeker:::bpapply(x, test_func,
                    apply_fun = BiocParallel::bpmapply,
                    MoreArgs = list(arg2 = y), progressbar = FALSE)
    expect_equal(res[1,2], 3)
})
