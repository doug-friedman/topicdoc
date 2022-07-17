#' Calculate diagnostics for each topic in a topic model
#'
#' Generate a dataframe containing the diagnostics for each topic in a topic model
#'
#'
#' @param topic_model a fitted topic model object from one of the following:
#' \code{\link[topicmodels]{tm-class}}
#' @param dtm_data a document-term matrix of token counts coercible to \code{slam_triplet_matrix}
#' where each row is a document, each column is a token,
#' and each entry is the frequency of the token in a given document
#' @param top_n_tokens an integer indicating the number of top words to consider for mean token length
#' @param method a string indicating which method to use -
#' "gamma_threshold" or "largest_gamma"
#' @param gamma_threshold a number between 0 and 1 indicating the gamma threshold to be used
#' when using the gamma threshold method, the default is 0.2
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
#' @export
#'
#' @examples
#'
#' # Using the example from the LDA function
#' library(topicmodels)
#' data("AssociatedPress", package = "topicmodels")
#' lda <- LDA(AssociatedPress[1:20,], control = list(alpha = 0.1), k = 2)
#' topic_diagnostics(lda, AssociatedPress[1:20,])

topic_diagnostics <- function(topic_model, dtm_data, top_n_tokens = 10,
                              method = c("gamma_threshold", "largest_gamma"),
                              gamma_threshold = 0.2){
  # Ensure the user passed a valid method argument
  method <- match.arg(method)

  # Check that the model and dtm contain the same number of documents
  if (!contain_equal_docs(topic_model, dtm_data)) {
    stop("The topic model object and document-term matrix contain an unequal number of documents.")
  }

  # Create a data frame with all of the diagnostics in the package
  data.frame(
    topic_num = 1:n_topics(topic_model),
    topic_size = topic_size(topic_model),
    mean_token_length = mean_token_length(topic_model),
    dist_from_corpus = dist_from_corpus(topic_model, dtm_data),
    tf_df_dist = tf_df_dist(topic_model, dtm_data),
    doc_prominence = doc_prominence(topic_model, method, gamma_threshold),
    topic_coherence = topic_coherence(topic_model, dtm_data, top_n_tokens),
    topic_exclusivity = topic_exclusivity(topic_model, top_n_tokens)
  )
}

#' Helper function to determine the number of topics in a topic model
#'
#' @param topic_model a fitted topic model object from one of the following:
#' \code{\link[topicmodels]{tm-class}}
#'
#' @keywords internal
#'
#' @return an integer indicating the number of topics in the topic model

n_topics <- function(topic_model){
  if (inherits(topic_model, "TopicModel")) {
    topic_model@k
  }
}

#' Helper function to check that a topic model and a dtm contain the same number of documents
#'
#' @param topic_model a fitted topic model object from one of the following:
#' \code{\link[topicmodels]{tm-class}}
#' @param dtm_data a document-term matrix of token counts coercible to \code{simple_triplet_matrix}
#'
#' @keywords internal
#'
#' @return a logical indicating whether or not the two object contain the same number of documents

contain_equal_docs <- function(topic_model, dtm_data){
  if (inherits(topic_model, "TopicModel")) {
    topic_model@Dim[1] == nrow(dtm_data)
  }
}
