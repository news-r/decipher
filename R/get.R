#' Get Token Names
#'
#' @param file File containing tagged names.
#' @param tag Character vector containing tagged names.
#'
#' @return \code{data.frame} of of 3 columns:
#' \enumerate{
#'   \item{string - string identified}
#'   \item{type - type of name}
#'   \item{name - extracted name}
#' }
#'
#' @examples
#' \dontrun{
#' # get working directory
#' # need to pass full path
#' wd <- getwd()
#'
#' # Training to find "WEF"
#' data <- paste("This organisation is called the <START:wef> World Economic Forum <END>",
#'   "It is often referred to as <START:wef> Davos <END> or the <START:wef> WEF <END> .")
#'
#' # train the model
#' model <- tnf_train(model = paste0(wd, "/wef.bin"), lang = "en",
#'   data = data, type = "wef")
#'
#' # Create sentences to test our model
#' sentences <- paste("This sentence mentions the World Economic Forum the annual meeting",
#'   "of which takes place in Davos. Note that the forum is often called the WEF.")
#'
#' # run model on sentences
#' results <- tnf(model = model, sentences = sentences)
#'
#' # extract strings
#' (ext <- get_names(results))
#' }
#'
#' @rdname get_tags
#' @export
get_names_ <- function(file){
  tags <- readLines(file)

  extract_tags(file)
}

#' @rdname get_tags
#' @export
get_names <- function(tag){
  extract_tags(tag)
}
