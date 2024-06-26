% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/confirm_meme_install.R
\name{confirm_meme_install}
\alias{confirm_meme_install}
\title{Stop if MEME suite is not installed}
\usage{
confirm_meme_install(meme_path = NULL)
}
\arguments{
\item{meme_path}{path to \verb{meme/bin/} (optional). Defaut: \code{NULL}, searches
"MEME_PATH" environment variable or "meme_path" option for path to "meme/bin/".}
}
\value{
Null
}
\description{
Stop if MEME suite is not installed
}
\seealso{
\code{\link[memes]{check_meme_install}}
}
\keyword{internal}
