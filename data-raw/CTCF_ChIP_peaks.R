CTCF_ChIP_peaks <- read_peak_file(
    "CTCF_ChIP_peaks.narrowPeak",
    file_format = "narrowpeak"
)
usethis::use_data(CTCF_ChIP_peaks, overwrite = TRUE)
