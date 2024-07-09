#' Stop if MEME suite is not installed
#' 
#' @inheritParams memes::runFimo
#' 
#' @importFrom memes meme_is_installed
#' 
#' @returns Null
#' 
#' @seealso \code{\link[memes]{check_meme_install}}
#' 
#' @keywords internal
confirm_meme_install <- function(meme_path = NULL) {
    stp_msg <- paste(
        "Cannot find MEME suite installation. If installed, try setting the",
        "path", shQuote("MEME_BIN"), "environment varaible, or use the",
        shQuote("meme_path"), "parameter in the MotifPeeker function call.",
        "\nFor more information, see the memes pacakge documention-",
        "\nhttps://github.com/snystrom/memes#detecting-the-meme-suite"
    )
    
    if (!memes::meme_is_installed(meme_path)) {
        stopper(stp_msg)
    }
}
