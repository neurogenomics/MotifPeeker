test_that("random_string works", {
  expect_equal(nchar(random_string(10)), 10)
})
