test_that("pretty_number works", {
    expect_equal(pretty_number(12.133), "12.13")
    expect_equal(pretty_number(1300.2), "1.3K")
    expect_equal(pretty_number(1593884, decimal_digits = 0), "2M")
    expect_equal(pretty_number(1593884333, decimal_digits = 2), "1.59B")
})
