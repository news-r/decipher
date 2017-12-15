#' Check OpenNLP tags
#'
#' @param file Full path to file containing tagged sentences, ussually a \code{.txt} file.
#'
#' @examples
#' \dontrun{
#' }
#'
#' @export
check_tags <- function(file){
  if(missing(file))
    stop("must pass file", call. = FALSE)

  text <- readLines(file)

  text <- gsub("<END>[[:punct:]]", " <END> .", text)

  write(text, file = file)
}
