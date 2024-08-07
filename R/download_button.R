#' Create a download button
#' 
#' Creates a download button for a file or directory, suitable to embed into
#' an HTML report.
#' 
#' @param path A character string specifying the path to the file or directory.
#' @param type A character string specifying the type of download. Either
#' \code{"file"} or \code{"dir"}.
#' @param add_button A logical indicating whether to add the download button to
#' the HTML report. (default = TRUE)
#' @inheritParams downloadthis::download_file
#' @inheritDotParams downloadthis::download_file
#' 
#' @importFrom htmltools tagList
#' 
#' @inherit downloadthis::download_file return
#' 
#' @seealso \code{\link[downloadthis]{download_file}}
#' 
#' @keywords internal
download_button <- function(path,
                            type,
                            button_label,
                            output_name = NULL,
                            button_type = "success",
                            has_icon = TRUE,
                            icon = "fa fa-save",
                            add_button = TRUE,
                            ...) {
    if (add_button) {
        wrn_msg <- paste("Package", shQuote("downloadthis"), "is required to",
                        "add download buttons to the HTML report. Skipping",
                        "download buttons...")
        check_dep("downloadthis", fatal = FALSE, custom_msg = wrn_msg)
        
        type <- tolower(type)
        if (type == "dir") {
            btn <- downloadthis::download_dir(
                path = path,
                output_name = output_name,
                button_label = button_label,
                button_type = button_type,
                has_icon = has_icon,
                icon = icon,
                self_contained = TRUE
            )
        } else if (type == "file") {
            btn <- downloadthis::download_file(
                path = path,
                output_name = output_name,
                button_label = button_label,
                button_type = button_type,
                has_icon = has_icon,
                icon = icon,
                self_contained = TRUE
            )
        }
        
        return(btn)
    } else {
        return(invisible())
    }
}
