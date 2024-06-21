motif_MA1930.2 <- read_motif_file(
    "motif_MA1930.2.jaspar",
    motif_id = "MA1930.2",
    file_format = "jaspar"
)
usethis::use_data(motif_MA1930.2, overwrite = TRUE)
