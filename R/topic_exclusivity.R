#' Calculate the exclusivity of each topic in a topic model
#'
#' Using the the N highest probability tokens for each topic, calculate
#' the exclusivity for each topic
#'
#' @param topic_model a fitted topic model object from one of the following:
#' \code{\link[topicmodels]{tm-class}}
#' @param top_n_tokens an integer indicating the number of top words to consider,
#' the default is 10
#' @param excl_weight a numeric between 0 and 1 indicating the weight to place on exclusivity
#' versus frequency in the calculation, 0.5 is the default
#'
#' @return A vector of exclusivity values with length equal to the number of topics in the fitted model
#'
#' @references {
#'   Bischof, Jonathan, and Edoardo Airoldi. 2012.
#'   "Summarizing topical content with word frequency and exclusivity."
#'   In Proceedings of the 29th International Conference on Machine Learning (ICML-12),
#'   eds John Langford and Joelle Pineau.New York, NY: Omnipress, 201–208.
#' }
#'
#' @importFrom topicmodels terms
#'
#' @export
#'
#' @seealso \code{\link[stm]{exclusivity}}
#'
#' @examples
#'
#' # Using the example from the LDA function
#' library(topicmodels)
#' data("AssociatedPress", package = "topicmodels")
#' lda <- LDA(AssociatedPress[1:20,], control = list(alpha = 0.1), k = 2)
#' topic_exclusivity(lda)

topic_exclusivity <- function(topic_model, top_n_tokens = 10,
                              excl_weight = 0.5){
  UseMethod("topic_exclusivity")
}
#' @export
topic_exclusivity.TopicModel <- function(topic_model, top_n_tokens = 10,
                                         excl_weight = 0.5){
  # Obtain the beta matrix from the topicmodel object
  beta_mat <- exp(topic_model@beta)

  # Normalize the beta values within each topic
  # SO link for reference - https://stats.stackexchange.com/a/51750
  beta_normed <- beta_mat %*% diag(1/colSums(beta_mat))

  # Calculate exclusivity (using approx ECDF)
  excls <- apply(beta_normed, 1, rank)/ncol(beta_normed)

  # Calculate frequency (using approx ECDF)
  freqs <- apply(beta_mat, 1, rank)/ncol(beta_mat)

  # Obtain the indicies of the top terms in the model
  # and select only those from the exclusivity and frequency matrices
  top_terms <- terms(topic_model, top_n_tokens)

  # Create an empty vector for the frex scores
  frex <- vector(length = ncol(freqs))

  # Loop through each topic's terms and calculate its total frex score
  for (i in 1:ncol(freqs)) {
    # Identifying and selecting rows for this topic's terms
    term_inds <- which(topic_model@terms %in% top_terms[,i])
    this_excls <- excls[term_inds, i]
    this_freqs <- freqs[term_inds, i]

    # Calculate frex score using the provided exclusivity weight
    excl_term <- excl_weight / this_excls
    freq_term <- (1 - excl_weight) / this_freqs
    frex[i] <- sum(1 / (excl_term + freq_term))
  }

  frex
}
