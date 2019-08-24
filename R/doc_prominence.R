#' Calculate the document prominence of each topic in a topic model
#'
#' Calculate the document prominence of each topic in a topic model based on either
#' the number of documents with an estimated gamma probability above a threshold or
#' the number of documents where a topic has the highest estimated gamma probability
#'
#' @param topic_model a fitted topic model object from one of the following:
#' \code{\link[topicmodels]{tm-class}}
#' @param method a string indicating which method to use -
#' "gamma_threshold" or "largest_gamma", the default is "gamma_threshold"
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
#' @export
#'
#' @examples
#'
#' # Using the example from the LDA function
#' library(topicmodels)
#' data("AssociatedPress", package = "topicmodels")
#' lda <- LDA(AssociatedPress[1:20,], control = list(alpha = 0.1), k = 2)
#' doc_prominence(lda)

doc_prominence <- function(topic_model, method = c("gamma_threshold", "largest_gamma"),
                           gamma_threshold = 0.2){
  UseMethod("doc_prominence")
}
#' @export
doc_prominence.TopicModel <- function(topic_model, method = c("gamma_threshold", "largest_gamma"),
                                      gamma_threshold = 0.2){
  # Ensure the user passed a valid method argument
  method <- match.arg(method)

  # Obtain the gamma matrix from the topicmodel object
  gamma_mat <- topic_model@gamma


  if (method == "gamma_threshold") {
    # Count the number of documents per topic that exceed the gamma threshold
    colSums(gamma_mat > gamma_threshold)
  } else {
    # Find the topic with the largest gamma per document
    row_maxs <- max.col(gamma_mat, ties.method = "first")

    # Sum up the results
    as.vector(table(row_maxs))
  }
}

