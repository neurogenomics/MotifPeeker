test_that("to_plotly works", {
    x <- data.frame(a = c(1,2,3), b = c(2,3,4))
    p <- ggplot(x, aes(x = a, y = b)) + geom_point()
    
    p1 <- to_plotly(p, html_tags = FALSE)
    expect_true(inherits(p1, "plotly"))
    
    p2 <- to_plotly(p, html_tags = TRUE)
    expect_true(inherits(p2, "shiny.tag.list"))
})
