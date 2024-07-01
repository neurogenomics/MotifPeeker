test_that("check_duplicate works", {
  dup_list <- list("label1", "label2", "label2")
  expect_error(check_duplicates(dup_list))
  
  unique_list <- list("label1", "label2", "label3")
  expect_silent(check_duplicates(unique_list))
})
