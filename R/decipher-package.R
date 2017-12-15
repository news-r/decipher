#' foo: A package to process natural language.
#'
#' Currently the package allows training and using name finder models.
#'
#' @section functions:
#' \itemize{
#'   \item{\code{\link{tnf}} to use a model and extract names from character vector.}
#'   \item{\code{\link{tnf_}} to use a model and extract names from file.}
#'   \item{\code{\link{tnf_train}} train a name finder model from character vector.}
#'   \item{\code{\link{tnf_train_}} train a name finder model from file.}
#'   \item{\code{\link{get_names}} extract identified names from character vector.}
#'   \item{\code{\link{get_names_}} extract identified names from file.}
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
#'   "It is often referred to as <START:wef> Davos <END> or the <START:wef> WEF <END>.")
#'
#' # Save the above as file
#' write(data, file = "input.txt")
#'
#' # Trains the model and returns the full path to the model
#' model <- tnf_train_(model = paste0(wd, "/wef.bin"), lang = "en",
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
#' output <- tnf_(model = model, sentences = paste0(wd, "/sentences.txt"),
#'   output = paste0(wd, "/output.txt"))
#'
#' # extract names
#' (names <- get_names(output))
#'
#' # You can train slightly more sophisticated models too
#' # Training to find sentiments
#' data <- paste("This sentence is <START:sentiment.neg> very bad <END> !",
#'   "This sentence is <START:sentiment.pos> rather good <END> .",
#'   "This sentence on the other hand, is <START:sentiment.neg> horrible <END> .")
#'
#' # Save the above as file
#' write(data, file = "input.txt")
#'
#' # Trains the model and returns the full path to the model
#' model <- tnf_train_(model = paste0(wd, "/sentiment.bin"), lang = "en",
#'   data = paste0(wd, "/input.txt"), type = "sentiment")
#'
#' # Create sentences to test our model
#' sentences <- paste("The first half of this sentence is a bad and negative while",
#'   "the second half is great and positive.")
#'
#' # Save sentences
#' write(data, file = "sentences.txt")
#'
#' # Extract names
#' # Without specifying an output file the extracted names appear in the console
#' tnf_(model = model, sentences = paste0(wd, "/sentences.txt"))
#' }
#'
#' @docType package
#' @name decipher
NULL
