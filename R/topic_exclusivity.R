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
#'   "Summarizingtopical content with word frequency and exclusivity."
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
  beta_mat <- exp(topic_model@beta)
  beta_normed <- beta_mat %*% diag(1/colSums(beta_mat))

  excls <- apply(beta_normed, 1, rank)/ncol(beta_normed)

  freqs <- apply(beta_mat, 1, rank)/ncol(beta_mat)

  top_terms <- terms(topic_model, top_n_tokens)
  term_inds <- which(topic_model@terms %in% top_terms[,1])

  excls <- excls[term_inds,]
  freqs <- freqs[term_inds,]

  excl_term <- excl_weight / excls
  freq_term <- (1 - excl_weight) / freqs
  frex <- 1 / (excl_term + freq_term)

  apply(frex, 2, sum)
}

