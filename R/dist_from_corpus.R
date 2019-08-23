#'
#' Calculate the distance of each topic from the overall corpus token distribution
#'
#' The Hellinger distance between the token probabilities or betas for each topic and
#' the overall probability for the word in the corpus is calculated.
#'
#' @param topic_model a fitted topic model object from one of the following:
#' \code{\link[topicmodels]{tm-class}}
#' @param dtm_data a document-term matrix of token counts coercible to \code{simple_triplet_matrix}
#'
#' @return A vector of distances with length equal to the number of topics in the fitted model
#'
#' @references {
#'   Jordan Boyd-Graber, David Mimno, and David Newman, 2014.
#'   \emph{Care and Feeding of Topic Models: Problems, Diagnostics, and Improvements.}
#'   CRC Handbooks ofModern Statistical Methods. CRC Press, Boca Raton, Florida.
#' }
#'
#' @importFrom topicmodels distHellinger
#' @importFrom slam col_sums as.simple_triplet_matrix
#'
#' @export
#'
#' @examples
#'
#' # Using the example from the LDA function
#' library(topicmodels)
#' data("AssociatedPress", package = "topicmodels")
#' lda <- LDA(AssociatedPress[1:20,], control = list(alpha = 0.1), k = 2)
#' dist_from_corpus(lda, AssociatedPress[1:20,])

dist_from_corpus <- function(topic_model, dtm_data){
  UseMethod("dist_from_corpus")
}
#' @export
dist_from_corpus.TopicModel <- function(topic_model, dtm_data){
  beta_mat <- exp(topic_model@beta)
  dtm_data <- as.simple_triplet_matrix(dtm_data)

  global_tf_counts <- col_sums(dtm_data, na.rm = TRUE)
  corpus_dist <- global_tf_counts/sum(global_tf_counts)

  distHellinger(beta_mat, matrix(corpus_dist, nrow = 1))[,1]
}
