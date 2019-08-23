#'
#' Calculate the average token length for each topic in a topic model
#'
#' Using the the N highest probability tokens for each topic, calculate
#' the average token length for each topic
#'
#' @param topic_model a fitted topic model object from one of the following:
#' \code{\link[topicmodels]{tm-class}}
#' @param top_n_tokens an integer indicating the number of top words to consider,
#' the default is 10
#'
#' @return A vector of average token lengths with length equal to the number of topics in the fitted model
#'
#' @references {
#'   Jordan Boyd-Graber, David Mimno, and David Newman, 2014.
#'   \emph{Care and Feeding of Topic Models: Problems, Diagnostics, and Improvements.}
#'   CRC Handbooks ofModern Statistical Methods. CRC Press, Boca Raton, Florida.
#' }
#'
#' @importFrom topicmodels terms
#'
#' @export
#'
#' @examples
#'
#' # Using the example from the LDA function
#' library(topicmodels)
#' data("AssociatedPress", package = "topicmodels")
#' lda <- LDA(AssociatedPress[1:20,], control = list(alpha = 0.1), k = 2)
#' mean_token_length(lda)

mean_token_length <- function(topic_model, top_n_tokens = 10){
  UseMethod("mean_token_length")
}
#' @export
mean_token_length.TopicModel <- function(topic_model, top_n_tokens = 10){
  top_terms <- terms(topic_model, top_n_tokens)
  nchar_mat <- apply(top_terms, 2, nchar)
  unname(colMeans(nchar_mat))
}
