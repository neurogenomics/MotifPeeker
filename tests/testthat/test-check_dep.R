test_that("check_dep works as expected", {
    # Check for invalid package name
    expect_error(check_dep("does_not_exist"))
    
    # Check for valid package name
    expect_silent(check_dep("base"))
    
    # Check for non-fatal checks
    expect_warning(check_dep("does_not_exist", fatal = FALSE, custom_msg =
                                "Custom message"))
})
