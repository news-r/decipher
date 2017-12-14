#' Learnable name finder
#'
#' @param model Model to use.
#' @param sentences Sentences containing entities to find, full path to file, usually \code{.txt}.
#' @param output An output file, generally \code{.txt}.
#'
#' @return Full path to the \code{output} if specified.
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
#' # Save the above as file
#' write(data, file = "input.txt")
#'
#' # Trains the model and returns the full path to the model
#' model <- tnf_train(model = paste0(wd, "/wef.bin"), lang = "en",
#'   data = paste0(wd, "/input.txt"), type = "wef")
#'
#' # Create sentences to test our model
#' sentences <- paste("This sentence mentions the World Economic Forum the annual meeting",
#'   "of which takes place in Davos. Note that the forum is often called the WEF.")
#'
#' # Save sentences
#' write(data, file = "sentences.txt")
#'
#' # Extract names
#' # Without specifying an output file the extracted names appear in the console
#' tnf(model = model, sentences = paste0(wd, "/sentences.txt"))
#'
#' # returns path to output file
#' output <- tnf(model = model, sentences = paste0(wd, "/sentences.txt"),
#'   output = paste0(wd, "/output.txt"))
#' }
#'
#'
#' @export
tnf <- function(model, sentences, output = NULL){

  if(missing(model) || missing(sentences))
    stop("must pass model and sentences", call. = FALSE)

  cmd <- paste("TokenNameFinder",
               model,
               "<", sentences)

  if(!is.null(output)) cmd <- paste(cmd, ">", output)

  try(system2("opennlp", args = cmd))

}

#' Train name finder model
#'
#' Train a name finder model.
#'
#' @param model Full path to output model file.
#' @param lang Language which is being processed.
#' @param data Data to be used, full path to file, usually \code{.txt}.
#' @param type The type of the token name finder model.
#' @param feature.gen Path to the feature generator descriptor file.
#' @param name.types Name types to use for training.
#' @param sequence.codec sequence codec used to code name spans.
#' @param factory A sub-class of \code{TokenNameFinderFactory}.
#' @param resources The resources directory.
#' @param params Training parameters file.
#' @param encoding Encoding for reading and writing text, if absent the system default is used.
#'
#' @return Full path to the \code{model} for convenience.
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
#' # Save the above as file
#' write(data, file = "input.txt")
#'
#' # Trains the model and returns the full path to the model
#' model <- tnf_train(model = paste0(wd, "/wef.bin"), lang = "en",
#'   data = paste0(wd, "/input.txt"), type = "wef")
#' }
#'
#' @export
tnf_train <- function(model, lang, data, feature.gen = NULL, name.types = NULL,
                        sequence.codec = NULL, factory = NULL, resources = NULL, params = NULL,
                        encoding = NULL, type = NULL){

  if(missing(model) || missing(lang) || missing(data))
    stop("must pass model, data, and lang", call. = FALSE)

  cmd <- paste("TokenNameFinderTrainer -model", model,
               "-data", data,
               "-lang", lang)

  if(!is.null(feature.gen)) cmd <- paste(cmd, "-featuregen", feature.gen)
  if(!is.null(name.types)) cmd <- paste(cmd, "-nameTypes", name.types)
  if(!is.null(sequence.codec)) cmd <- paste(cmd, "-sequenceCodec", sequence.codec)
  if(!is.null(factory)) cmd <- paste(cmd, "-factory", factory)
  if(!is.null(resources)) cmd <- paste(cmd, "-resources", resources)
  if(!is.null(params)) cmd <- paste(cmd, "-params", params)
  if(!is.null(encoding)) cmd <- paste(cmd, "-encoding", encoding)
  if(!is.null(type)) cmd <- paste(cmd, "-type", type)

  # opennlp tokenNameFinderTrainer -model /path/to/model/model.bin -lang en -data /path/to/input.txt
  try(system2("opennlp", args = cmd))
  return(model)
}
