#'
#' Calculate the topic coherence for each topic in a topic model
#'
#' Using the the N highest probability tokens for each topic, calculate
#' the topic coherence for each topic
#'
#' @param topic_model a fitted topic model object from one of the following:
#' \code{\link[topicmodels]{tm-class}}
#' @param dtm_data a document-term matrix of token counts coercible to \code{simple_triplet_matrix}
#' @param top_n_tokens an integer indicating the number of top words to consider,
#' the default is 10
#' @param smoothing_beta a numeric indicating the value to use to smooth the document frequencies
#' in order avoid log zero issues, the default is 1
#'
#' @return A vector of topic coherence scores with length equal to the number of topics in the fitted model
#'
#' @references {
#'   Mimno, D., Wallach, H. M., Talley, E., Leenders, M., & McCallum, A. (2011, July).
#'   "Optimizing semantic coherence in topic models." In Proceedings of the Conference on
#'   Empirical Methods in Natural Language Processing (pp. 262-272). Association for
#'   Computational Linguistics. Chicago
#'
#'   McCallum, Andrew Kachites.  "MALLET: A Machine Learning for Language Toolkit."
#'   \url{http://mallet.cs.umass.edu.} 2002.
#' }
#'
#' @seealso \code{\link[stm]{semanticCoherence}}
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
#' topic_coherence(lda, AssociatedPress[1:20,])

topic_coherence <- function(topic_model, dtm_data, top_n_tokens = 10,
                            smoothing_beta = 1){
  UseMethod("topic_coherence")
}
#' @export
topic_coherence.TopicModel <- function(topic_model, dtm_data, top_n_tokens = 10,
                                       smoothing_beta = 1){
  # Get top terms for each topic
  top_terms <- terms(topic_model, top_n_tokens)

  # Coerce document-term matrix to simple triplet matrix
  dtm_data <- as.simple_triplet_matrix(dtm_data)

  # Apply coherence calculation to all topics' top terms
  unname(apply(top_terms, 2, coherence, dtm_data = dtm_data, smoothing_beta = smoothing_beta))
}


#' Helper function for calculating coherence for a single topic's worth of terms
#'
#' @param dtm_data a document-term matrix of token counts coercible to \code{simple_triplet_matrix}
#' @param top_terms a character vector of the top terms for a given topic
#' @param smoothing_beta a numeric indicating the value to use to smooth the document frequencies
#' in order avoid log zero issues, the default is 1
#'
#' @importFrom slam tcrossprod_simple_triplet_matrix
#'
#' @return a numeric indicating coherence for the topic

coherence <- function(dtm_data, top_terms, smoothing_beta){
  # Get the relevant entries of the document-term matrix
  rel_dtm <- dtm_data[,top_terms]

  # Turn it into a logical representing co-occurences
  df_dtm <- rel_dtm > 0

  # Calculate document frequencies for each term and all of its co-occurences
  cooc_mat <- tcrossprod_simple_triplet_matrix(t(df_dtm))

  top_n_tokens <- length(top_terms)

  # Using the syntax from the paper, calculate coherence
  c_l <- 0
  for (m in 2:top_n_tokens) {
    for (l in 1:(top_n_tokens - 1)) {
      df_ml <- cooc_mat[m,l]
      df_l <- cooc_mat[l,l]
      c_l <- c_l + log((df_ml + smoothing_beta) / df_l)
    }
  }

  c_l
}
