#' Access PDS3 Lexer & Parser
#'
#' Provides access to the underlying lexer & parser to process PDS3 files
#'
#' Typically you don't need to access this directly, but if you are processing
#' a large number of files you may want to cache this and pass it in to
#' `read_pds3` manually to prevent them from being re-created on each run.
#'
#' @param debug (default: FALSE) Sets lexer/parser to debug mode for testing.
#' @return A list with the following components:
#'   \describe{
#'     \item{lexer}{The rly lexer}
#'     \item{parser}{The rly parser}
#'   }
#' @examples
#'util <- pds3_lexer_parser()
#' @export
pds3_lexer_parser <- function(debug = FALSE) {
  return(list(
    lexer  = rly::lex(odl_lexer),
    parser = rly::yacc(parser)
  ))
}
