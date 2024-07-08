test_that("print_labels works", {
    exp_labels <- c("Exp1", "Exp2", "Exp3")
    read_counts <- c(100, 200, 300)
    expect_invisible(print_labels(exp_labels, 1, 2, "known_motif", read_counts))
    expect_invisible(print_labels(exp_labels, 1, 2, "denovo_motif"))
})
