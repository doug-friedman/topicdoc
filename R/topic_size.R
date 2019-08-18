#' Calculate the size of each topic in a topic model
#'
#' Calculate the size of each topic in a topic model based on the
#' number of fractional tokens found in each topic.
#' @param topic_model a fitted topic model object
#'
#' @return A vector of topic sizes with length equal to the number of topics in the fitted model
#'
#' @references {
#'   Jordan Boyd-Graber, David Mimno, and David Newman,2014.
#'   \emph{Care and Feeding of Topic Models: Problems,Diagnostics, and Improvements.}
#'   CRC Handbooks ofModern Statistical Methods. CRC Press, Boca Raton,Florida.
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
#' topic_size(lda)

topic_size <- function(topic_model){
  UseMethod("topic_size")
}
#' @export
topic_size.LDA <- function(topic_model){
  beta_mat <- exp(topic_model@beta)
  # SO link for reference - https://stats.stackexchange.com/a/51750
  beta_normed <- beta_mat %*% diag(1/colSums(beta_mat))
  rowSums(beta_normed)
}

