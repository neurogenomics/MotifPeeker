#' Example TIP-seq peak file
#' 
#' Human CTCF peak file generated with TIP-seq using HCT116 cell-line.
#' The peak file was generated using the
#' \href{https://nf-co.re/cutandrun/3.2.2}{nf-core/cutandrun} pipeline.
#' Raw read files were sourced from \emph{NIH Sequence Read Archives}
#' (ID: \href{https://trace.ncbi.nlm.nih.gov/Traces/index.html?view=run_browser&acc=SRR16963166}{SRR16963166}).
#' 
#' @note To reduce the size of the package, the included peak file focuses on
#' specific genomic regions. The subset region included is
#' chr10:65,654,529-74,841,155.
#' 
#' @usage data("CTCF_TIP_peaks")
"CTCF_TIP_peaks"

#' Example ChIP-seq peak file
#' 
#' Human CTCF peak file generated with ChIP-seq using HCT116 cell-line. No
#' control files were used to generate the peak file.
#' 
#' @source \href{https://www.encodeproject.org/files/ENCFF091ODJ/}{ENCODE Accession: ENCFF091ODJ}
#' 
#' @inherit CTCF_TIP_peaks note
#' 
#' @usage data("CTCF_ChIP_peaks")
"CTCF_ChIP_peaks"

#' Example CTCFL JASPAR motif file
#' 
#' The motif file contains the JASPAR motif for CTCFL (MA1102.3) for
#' \emph{Homo Sapiens}. This is one of the two motif files used to demonstrate
#' \code{\link{MotifPeeker}}'s known-motif analysis functionality.
#' 
#' @source \href{https://jaspar.elixir.no/matrix/MA1102.3/}{JASPAR Matrix ID: MA1102.3}
#' 
#' @usage data("motif_MA1102.3")
"motif_MA1102.3"

#' Example CTCF JASPAR motif file
#' 
#' The motif file contains the JASPAR motif for CTCF (MA1930.2) for
#' \emph{Homo Sapiens}. This is one of the two motif files used to demonstrate
#' \code{\link{MotifPeeker}}'s known-motif analysis functionality.
#' 
#' @source \href{https://jaspar.elixir.no/matrix/MA1930.2/}{JASPAR Matrix ID: MA1930.2}
#' 
#' @usage data("motif_MA1930.2")
"motif_MA1930.2"
