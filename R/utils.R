extract_tags <- function(x){
  x <- stringr::str_match_all(x, "<START(.*?)>(.*?)<END>")[[1]]
  x <- tibble::as.tibble(x)
  names(x) <- c("string", "type", "name")

  # clean
  x$name <- trimws(as.character(x$name))
  x$name <- gsub("[[:punct:]]", "", x$name)

  # clean type
  x$type <- gsub(":", "", x$type)
  x
}
