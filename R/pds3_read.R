#' Parse PDS3
#'
#' Parses a PDS3 file to extract meta information
#'
#' @param x A String of the PDS3 to parse, containing one of the following:
#'   \describe{
#'     \item{Content}{String you want to parse}
#'     \item{Filename}{Path to a file containing a PDS3}
#'   }
#' @param assume_complete (default: TRUE) Assume that there is no content after
#'   'END'. If set to false, will pre-parse the file to find END. If you start
#'   getting parsing errors, you may need to set this flag to false.
#' @param util A list containing a PDS3 lexer & parser as returned by
#'   `getLexerParser()`. Typically not required, but improves performance if
#'   parsing many files.
#' @return A list with the following components:
#'   \describe{
#'     \item{label}{Raw label content. If there is extra_data, it will be excluded}
#'     \item{extra_data}{Content following 'END'. If assume_complete is F or
#'       there is no content after the label, this will be  an empty string}
#'     \item{odl}{Parsed label content.}
#'   }
#' @examples
#'pds3_read('PDS_VERSION_ID = PDS3
#'  PRODUCT_CREATION_TIME         = 2017-05-31T18:42:49
#'  END')
#' @export
pds3_read <- function(x, util = pds3_lexer_parser(), assume_complete = TRUE) {
  # Check if x is a file
  if (nchar(x) < 500) {
    if (file.exists(x)) {
      x <- readChar(x, file.info(x)$size)
    }
  }

  # Reset lexer/parser to be sure...
  util$parser$restart()

  # get just the label
  # TODO: This should respect a "extract.data" parameter and stop at the END to
  # avoid long files.
  dat <- list(label = x, extra_data = "")
  if (!assume_complete) {
    dat <- extract(x)
  }

  dat$odl <- reduce(util$parser$parse(dat$label, util$lexer))

  return(dat)
}
