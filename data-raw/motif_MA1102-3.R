motif_MA1102.3 <- read_motif_file(
    "motif_MA1102.3.jaspar",
    motif_id = "MA1102.3",
    file_format = "jaspar"
)
usethis::use_data(motif_MA1102.3, overwrite = TRUE)
