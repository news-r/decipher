#' Train Document Classifer
#'
#' Train document classifier.
#'
#' @param model Full path to Output model file.
#' @param lang Language which is being processed.
#' @param data a data.frame of classifed documents, see details and examples.
#'
#' @details \code{data} is a data.frame of 2 columns:
#' \enumerate{
#'   \item{class - the dodcument class}
#'   \item{document - the document}
#' }
#'
#' @examples
#' \dontrun{
#' # get working directory
#' # need to pass full path
#' wd <- getwd()
#'
#' data <- data.frame(class = c("Sport", "Business", "Sport", "Sport"),
#'   doc = c("Football, tennis, golf and, bowling and, score",
#'           "Marketing, Finance, Legal and, Administration",
#'           "Tennis, Ski, Golf and, gym and, match",
#'           "football, climbing and gym"))
#'
#' # Error not enough data
#' # model <- dc_train(model = paste0(wd, "/model.bin"), data = data, lang = "en")
#'
#' # repeat data 50 times
#' # Obviously do not do that in te real world
#' data <- do.call("rbind", replicate(50, data, simplify = FALSE))
#'
#' # train model
#' model <- dc_train(model = paste0(wd, "/model.bin"), data = data, lang = "en")
#' }
#'
#' @export
dc_train <- function(model, lang, data){

  temp <- tempfile(fileext = ".txt")
  write.table(data, file = temp, row.names = FALSE, col.names = FALSE)

  cmd <- paste("DoccatTrainer -model", model, "-lang", lang, "-data", temp)

  unlink("temp", recursive = TRUE)

  try(system2("opennlp", args = cmd))

  return(model)
}

#' Document classifier
#'
#' Classify document.
#'
#' @param model Model to use, generally returned by \code{\link{dc_train}}.
#' @param documents Documents to classify.
#' @param output Full path to output file.
#'
#' @examples
#' \dontrun{
#' # get working directory
#' # need to pass full path
#' wd <- getwd()
#'
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
#' @rdname dc
#' @export
dc_ <- function(model, documents, output = NULL){

  if(missing(model) || missing(documents))
    stop("must pass model and documents", call. = FALSE)

  cmd <- paste("TokenNameFinder",
               model, "<", documents)

  if(!is.null(output)) cmd <- paste(cmd, ">", output)

  try(system2("opennlp", args = cmd))

  if(!is.null(output))
    return(output)

}

#' @rdname dc
#' @export
dc <- function(model, documents){

  output <- tempfile(fileext = ".txt")
  temp <- tempfile(fileext = ".txt")
  write.table(documents, file = temp, row.names = FALSE, col.names = FALSE)

  path <- dc_(model, temp, output = output)

  unlink("temp", recursive = TRUE)

  results <- readLines(path)

  unlink("output", recursive = TRUE)

  return(results)

}
