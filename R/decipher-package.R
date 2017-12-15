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
#'   \item{\code{\link{dc}} classify documents.}
#'   \item{\code{\link{dc_train}} train document classifier from character vector.}
#'   \item{\code{\link{dc_train_}} train document classifer from file.}
#' }
#'
#' @examples
#' \dontrun{
#' # get working directory
#' # need to pass full path
#' wd <- getwd()
#'
#' # Name extraction
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
#' # Classification
#' # create dummy data
#' data <- data.frame(class = c("Sport", "Business", "Sport", "Sport"),
#'   doc = c("Football, tennis, golf and, bowling and, score",
#'           "Marketing, Finance, Legal and, Administration",
#'           "Tennis, Ski, Golf and, gym and, match",
#'           "football, climbing and gym"))
#'
#' # repeat data 50 times to have enough data
#' # Obviously do not do that in te real world
#' data <- do.call("rbind", replicate(50, data, simplify = FALSE))
#'
#' # train model
#' model <- dc_train(model = paste0(wd, "/model.bin"), data = data, lang = "en")
#'
#' # create documents to classify
#' documents <- data.frame(
#'   docs = c("This discusses golf which is a sport.",
#'            "This documents is about business administration.",
#'            "This is about people who do sport, go to the gym and play tennis.",
#'            "Some play tennis and work in Finance")
#' )
#'
#' # classify documents
#' classified <- dc(model, documents)
#' }
#'
#' @importFrom utils write.table
#'
#' @docType package
#' @name decipher
NULL
