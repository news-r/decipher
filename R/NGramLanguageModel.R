#' N-gram language model
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
#' ngram <- nglm(model)
#' }
#'
#' @keywords internal
nglm <- function(model, output = NULL){

  if(is.null(output))
    output <- tempfile(fileext = ".txt")

  cmd <- paste("NGramLanguageModel", model)

  try(system2("opennlp", args = cmd))

  if(is.null(output))
    unlink("output", recursive = TRUE) # delete temp once read

  return(model)
}
