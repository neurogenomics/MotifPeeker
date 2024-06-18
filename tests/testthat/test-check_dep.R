test_that("check_dep works as expected", {
    # Check for invalid package name
    expect_error(check_dep("def_does_not_exist"))
    
    # Check for valid package name
    expect_silent(check_dep("base"))
})
