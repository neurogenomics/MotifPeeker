test_that("confirm_meme_install works", {
  if (memes::meme_is_installed()) {
    expect_silent(confirm_meme_install())
  } else {
    expect_error(confirm_meme_install())
  }
})
