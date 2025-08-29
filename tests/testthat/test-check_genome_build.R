test_that("check_genome works", {
    # Check keywords
    genome_build <- check_genome_build("hg38")
    expect_true(
        identical(
            genome_build,
            BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
        )
    )
    genome_build <-
        check_genome_build(BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19)
    expect_true(
        identical(
            check_genome_build(genome_build),
            BSgenome.Hsapiens.UCSC.hg19::BSgenome.Hsapiens.UCSC.hg19
        )
    )
    expect_error(check_genome_build("hg37"))
    
    # Check BSgenome object
    genome_build <-
        BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
    expect_true(
        identical(
            check_genome_build(genome_build),
            BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
        )
    )
})
