#' Check OpenNLP Tags
#'
#' @param file Full path to file containing tagged sentences, ussually a \code{.txt} file.
#' @param tag Tagged character vector.
#'
#' @examples
#' \dontrun{
#' data <- "some sentence with <START:tag> erroneous tag <END>."
#'
#' # corrected tags
#' data <- check_tags(data)
#' }
#'
#' @rdname checktags
#' @export
check_tags_ <- function(file){
  if(missing(file))
    stop("must pass file", call. = FALSE)

  text <- readLines(file)

  text <- gsub("<END>[[:punct:]]", "<END> .", text)

  write(text, file = file)

  return(text)
}

#' @rdname checktags
#' @export
check_tags <- function(tag){
  if(missing(tag))
    stop("must pass tag", call. = FALSE)

  text <- gsub("<END>[[:punct:]]", "<END> .", tag)

  return(text)
}

#' Tag Documents
#'
#' Tag terms for \code{\link{tnf_train}}.
#'
#' @param docs Documents to tag.
#' @param terms Regular expression to tag.
#' @param tag Tag.
#' @param check If \code{TRUE} checks the tags using \code{\link{check_tags}}.
#'
#' @examples
#' data <- paste("This organisation is called the World Economic Forum",
#'   "It is often referred to as Davos or the WEF.")
#'
#' data <- tag_docs(data, "WEF", "wef")
#' data <- tag_docs(data, "World Economic Forum", "wef")
#' data <- tag_docs(data, "Davos", "wef")
#'
#' cat(data)
#'
#' @export
tag_docs <- function(docs, terms, tag, check = TRUE){

  if(missing(docs) || missing(terms) || missing(tag))
    stop("missing docs, regex or tag", call. = FALSE)

  tagged <- paste0("<START:", tag, "> ", terms, " <END>")

  docs <- gsub(terms, tagged, docs)

  if(isTRUE(check))
    docs <- check_tags(docs)

  docs
}
