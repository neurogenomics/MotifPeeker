test_that("MotifPeeker fails without genome_build input", {
  expect_error(MotifPeeker())
})
test_that(paste(
    "MotifPeeker fails if both alignment_files",
    "and peak_files are missing"
),
{
    expect_error(MotifPeeker(genome_build = "hg19"))
})
