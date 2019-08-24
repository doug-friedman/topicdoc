setup(
  data("AssociatedPress", package = "topicmodels")
)

# Test LDA VEM model from topicmodels
test_that("LDA VEM", {
  lda_vem <- readRDS("test_data/test_lda_vem.RDS")
  diag_df <- topic_diagnostics(lda_vem, AssociatedPress[1:20,],
                               method = "largest_gamma")

  expect_is(diag_df, "data.frame")
  expect_equal(diag_df$topic_num, 1:3)
  expect_equal(diag_df$topic_size, topic_size(lda_vem))
  expect_equal(diag_df$mean_token_length, mean_token_length(lda_vem))
  expect_equal(diag_df$dist_from_corpus, dist_from_corpus(lda_vem, AssociatedPress[1:20,]))
  expect_equal(diag_df$tf_df_dist, tf_df_dist(lda_vem, AssociatedPress[1:20,]))
  expect_equal(diag_df$doc_prominence, doc_prominence(lda_vem, "largest_gamma"))
  expect_equal(diag_df$topic_coherence, topic_coherence(lda_vem, AssociatedPress[1:20,]))
  expect_equal(diag_df$topic_exclusivity, topic_exclusivity(lda_vem))
})
