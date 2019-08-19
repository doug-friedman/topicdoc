#' Calculate the document prominence of each topic in a topic model
#'
#' Calculate the document prominence of each topic in a topic model based on either
#' the number of documents with an estimated gamma probability above a threshold or
#' the number of documents where a topic has the highest estimated gamma probability
#'
#' @param topic_model a fitted topic model object from one of the following:
#' \code{\link[topicmodels]{LDA}}, \code{\link[topicmodels]{CTM}}
#' @param method a string indicating which method to use -
#' "gamma_threshold" or "largest_gamma"
#' @param gamma_threshold a number between 0 and 1 indicating the gamma threshold to be used
#' when using the gamma threshold method, the default is 0.2
#'
#' @return A vector of document prominences with length equal to the number of topics in the fitted model
#'
#' @references {
#'   Jordan Boyd-Graber, David Mimno, and David Newman, 2014.
#'   \emph{Care and Feeding of Topic Models: Problems, Diagnostics, and Improvements.}
#'   CRC Handbooks ofModern Statistical Methods. CRC Press, Boca Raton, Florida.
#' }
#'
#' @seealso
#' \code{\link[topicmodels]{LDA}}, \code{\link[topicmodels]{CTM}}
#'
#' @export
#'
#' @examples
#'
#' # Using the example from the LDA function
#' library(topicmodels)
#' data("AssociatedPress", package = "topicmodels")
#' lda <- LDA(AssociatedPress[1:20,], control = list(alpha = 0.1), k = 2)
#' doc_prominence(lda, "largest_gamma")

doc_prominence <- function(topic_model, method, gamma_threshold = 0.2){
  UseMethod("doc_prominence")
}
#' @export
doc_prominence.TopicModel <- function(topic_model, method, gamma_threshold = 0.2){
  gamma_mat <- topic_model@gamma

  if (method == "gamma_threshold") {
    colSums(gamma_mat > gamma_threshold)
  } else {
    row_maxs <- max.col(gamma_mat, ties.method = "first")
    as.vector(table(row_maxs))
  }
}

