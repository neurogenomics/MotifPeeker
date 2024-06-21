CTCF_TIP_peaks <- read_peak_file(
    "CTCF_TIP_peaks.narrowPeak",
    file_format = "narrowpeak"
)
usethis::use_data(CTCF_TIP_peaks, overwrite = TRUE)
