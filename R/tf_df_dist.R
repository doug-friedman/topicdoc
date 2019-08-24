#' Calculate the distance between token and document frequencies
#'
#' Using the the N highest probability tokens for each topic,
#' calculate the Hellinger distance between the token frequencies and
#' the document frequencies
#'
#' @param topic_model a fitted topic model object from one of the following:
#' \code{\link[topicmodels]{tm-class}}
#' @param dtm_data a document-term matrix of token counts coercible to \code{simple_triplet_matrix}
#' @param top_n_tokens an integer indicating the number of top words to consider,
#' the default is 10
#'
#' @return A vector of distances with length equal to the number of topics in the fitted model
#'
#' @references {
#'   Jordan Boyd-Graber, David Mimno, and David Newman, 2014.
#'   \emph{Care and Feeding of Topic Models: Problems, Diagnostics, and Improvements.}
#'   CRC Handbooks ofModern Statistical Methods. CRC Press, Boca Raton, Florida.
#' }
#'
#' @importFrom topicmodels terms
#' @importFrom slam as.simple_triplet_matrix
#'
#' @export
#'
#' @examples
#'
#' # Using the example from the LDA function
#' library(topicmodels)
#' data("AssociatedPress", package = "topicmodels")
#' lda <- LDA(AssociatedPress[1:20,], control = list(alpha = 0.1), k = 2)
#' tf_df_dist(lda, AssociatedPress[1:20,])

tf_df_dist <- function(topic_model, dtm_data, top_n_tokens = 10){
  UseMethod("tf_df_dist")
}
#' @export
tf_df_dist.TopicModel <- function(topic_model, dtm_data, top_n_tokens = 10){
  # Obtain the top terms from the topicmodel object
  top_terms <- terms(topic_model, top_n_tokens)

  # Coerce dtm to slam format
  dtm_data <- as.simple_triplet_matrix(dtm_data)

  # Calculate distance b/w token frequency/document frequency for each topic
  unname(apply(top_terms, 2, tf_df_dist_diff, dtm_data = dtm_data))
}



#' Helper function to calculate the Hellinger distance
#' between the token frequencies and document frequencies
#' for a specific topic's top N tokens
#'
#' @param dtm_data a document-term matrix of token counts coercible to \code{simple_triplet_matrix}
#' @param top_terms - a character vector of the top N tokens
#'
#' @importFrom slam col_sums
#'
#' @return a single value representing the Hellinger distance

tf_df_dist_diff <- function(dtm_data, top_terms){
  # Obtain the indicies of the top terms in the dtm
  # and select only those
  top_terms_inds <- which(colnames(dtm_data) %in% top_terms)
  rel_dtm <- dtm_data[,top_terms_inds]

  # Calculate the token frequencies and document frequencies
  # using slam to keep things sparse
  tf_counts <- col_sums(rel_dtm)
  df_counts <- col_sums(rel_dtm > 0)

  # Using the Hellinger distance, calculate the distance
  # of each topic's token frequencies from its document frequencies
  distHellinger(matrix(tf_counts, nrow = 1),
                matrix(df_counts, nrow = 1))
}
