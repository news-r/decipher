#' Check OpenNLP tags
#'
#' @param file Full path to file containing tagged sentences, ussually a \code{.txt} file.
#'
#' @examples
#' \dontrun{
#' data <- paste("This organisation is called the <START:wef> World Economic Forum <END>.",
#'   "It is often referred to as <START:wef> Davos <END> or the <START:wef> WEF <END>.")
#'
#' write(data, file = "input.txt")
#'
#' check_tags("input.txt")
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
