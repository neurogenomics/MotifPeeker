#' Check for ENCODE input
#' 
#' Check and get files from ENCODE project. Requires the input to be in ENCODE
#' ID format. Uses BiocFileCache to cache downloads. Only works for files.
#' 
#' @param encode_id A character string specifying the ENCODE ID.
#' @param expect_format A character string (or a vector) specifying the expected
#' format(s) of the file. If the file is not in the expected format, an error is
#' thrown.
#' @inheritParams MotifPeeker
#' 
#' @returns A character string specifying the path to the downloaded file.
#' 
#' @examples
#' if (requireNamespace("curl", quietly = TRUE) &&
#'     requireNamespace("jsonlite", quietly = TRUE)) {
#'     check_ENCODE("ENCFF920TXI", expect_format = c("bed", "gz"))
#' }
#' 
#' @export
check_ENCODE <- function(encode_id, expect_format, verbose = FALSE) {
    ### Validate ENCODE ID ###
    stp_msg <- "Input is not a ENCODE ID string."
    id_pattern <- "^ENC(SR|BS|DO|GM|AB|LB|FF|PL)\\d{3}[A-Z]{3}$"
    if (!(all(is.character(encode_id)) && all(grepl(id_pattern, encode_id)))) {
        stop(stp_msg)
    }
    
    ### Verify existence of file on ENCODE ###
    check_dep("curl")
    check_dep("jsonlite")
    json_url <- paste0("https://www.encodeproject.org/files/",
                        encode_id, "/?format=json")
    json_data <- (curl::curl_fetch_memory(json_url))$content |>
        rawToChar() |>
        jsonlite::fromJSON()
    
    ## Check data
    if (!grepl(id_pattern, json_data$accession) || is.null(json_data$href)) {
        stp_msg <- paste("Error downloading ENCODE JSON data.",
                            "Check if ID is correct and leads to a file.")
        stop(stp_msg)
    }
    ext <- basename(tools::file_ext(json_data$href))
    if (!ext %in% expect_format) {
        stp_msg <- paste0("Error downloading file from ENCODE.\n",
                            "Expected file format: ", expect_format,
                            " but got: ", ext)
        stop(stp_msg)
    }
    
    ### Fetch file ###
    file_url <- paste0("https://www.encodeproject.org", json_data$href)
    return(use_cache(file_url, verbose = verbose))
}
