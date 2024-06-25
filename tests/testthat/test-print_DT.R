test_that("print_DT works", {
  df <- data.frame(
    a = c(1, 2, 3),
    b = c(4, 5, 6)
  )
  expect_type(print_DT(df), "list")
  expect_type(print_DT(df, extra = TRUE), "list")
})
