#' Calculate diagnostics for each topic in a topic model
#'
#' Generate a dataframe containing the diagnostics for each topic in a topic model
#'
#'
#' @param topic_model a fitted topic model object from one of the following:
#' \code{\link[topicmodels]{LDA}}, \code{\link[topicmodels]{CTM}}
#' @param dtm_data a document-term matrix of token counts coercible to \code{slam_triplet_matrix}
#' where each row is a document, each column is a token,
#' and each entry is the frequency of the token in a given document
#' @param top_n_tokens an integer indicating the number of top words to consider for mean token length
#'
#' @return A dataframe where each row is a topic and each column contains
#' the associated diagnostic values
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
#' topic_diagnostics(lda, AssociatedPress[1:20,])

topic_diagnostics <- function(topic_model, dtm_data, top_n_tokens = 10){
  UseMethod("topic_diagnostics")
}
#' @export
topic_diagnostics.TopicModel <- function(topic_model, dtm_data, top_n_tokens = 10){
  data.frame(
    topic_num = 1:topic_model@k,
    topic_size = topic_size(topic_model),
    mean_token_length = mean_token_length(topic_model),
    dist_from_corpus = dist_from_corpus(topic_model, dtm_data)
  )
}

