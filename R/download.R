#' Download
#'
#' List existing models.
#'
#' @examples
#' list_models()
#'
#' @name dl
#' @export
list_models <- function(){
  url <- "http://opennlp.sourceforge.net/models-1.5/"
  x <- xml2::read_html(url)
  x <- rvest::html_node(x, "#model-download")
  table <- rvest::html_table(x)
  table$Link <- paste0("http://opennlp.sourceforge.net/models-1.5/", table$Download)
  return(table)
}

