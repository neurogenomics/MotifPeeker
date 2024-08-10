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
test_that("MotifPeeker produces output files", {
    peaks <- list(
        system.file("extdata", "CTCF_ChIP_peaks.narrowPeak",
                    package = "MotifPeeker"),
        system.file("extdata", "CTCF_TIP_peaks.narrowPeak",
                    package = "MotifPeeker")
    )
    
    alignments <- list(
        system.file("extdata", "CTCF_ChIP_alignment.bam",
                    package = "MotifPeeker"),
        system.file("extdata", "CTCF_TIP_alignment.bam",
                    package = "MotifPeeker")
    )
    
    motifs <- list(
        system.file("extdata", "motif_MA1930.2.jaspar",
                    package = "MotifPeeker"),
        system.file("extdata", "motif_MA1102.3.jaspar",
                    package = "MotifPeeker")
    )
    
    ## All optional features enabled
    out_dir <- MotifPeeker(
        peak_files = peaks,
        reference_index = 1,
        alignment_files = alignments,
        exp_labels = c("ChIP", "TIP"),
        exp_type = c("chipseq", "tipseq"),
        genome_build = "hg38",
        motif_files = motifs,
        motif_labels = c("MA1930.2", "MA1102.3"),
        cell_counts = NULL,
        denovo_motif_discovery = TRUE,
        denovo_motifs = 2,
        motif_db = NULL,
        download_buttons = TRUE,
        workers = 1,
        out_dir = tempdir(),
        display = NULL,
        debug = FALSE,
        verbose = FALSE
    )
    expect_true(file.exists(file.path(out_dir, "MotifPeeker.html")))
    
    ## No alignment and motif files
    out_dir <- MotifPeeker(
      peak_files = peaks,
      reference_index = 1,
      alignment_files = NULL,
      exp_labels = c("ChIP", "TIP"),
      exp_type = c("chipseq", "tipseq"),
      genome_build = "hg38",
      motif_files = NULL,
      motif_labels = NULL,
      cell_counts = NULL,
      denovo_motif_discovery = TRUE,
      denovo_motifs = 1,
      trim_seq_width = 100,
      motif_db = NULL,
      download_buttons = TRUE,
      out_dir = tempdir(),
      workers = 1,
      display = NULL,
      debug = FALSE,
      verbose = FALSE
    )
    expect_true(file.exists(file.path(out_dir, "MotifPeeker.html")))

    ## Single set of files
    ## Also, try with built-in data
    data("CTCF_ChIP_peaks", package = "MotifPeeker")
    data("motif_MA1930.2", package = "MotifPeeker")
    out_dir <- MotifPeeker(
      peak_files = CTCF_ChIP_peaks,
      reference_index = 1,
      alignment_files = alignments[1],
      exp_labels = c("ChIP"),
      exp_type = c("chipseq"),
      genome_build = "hg38",
      motif_files = motif_MA1930.2,
      motif_labels = NULL,
      cell_counts = NULL,
      denovo_motif_discovery = TRUE,
      denovo_motifs = 1,
      trim_seq_width = 100,
      motif_db = NULL,
      download_buttons = TRUE,
      out_dir = tempdir(),
      workers = 1,
      display = NULL,
      debug = FALSE,
      verbose = FALSE
    )
    expect_true(file.exists(file.path(out_dir, "MotifPeeker.html")))
})
