# Test LDA VEM model from topicmodels
test_that("LDA VEM", {
  lda_vem <- readRDS("test_data/test_lda_vem.RDS")
  expect_equal(mean_token_length(lda_vem), c(5.1, 6.4, 5.3))
})

# Test LDA Gibbs model from topicmodels
test_that("LDA Gibbs", {
  lda_gibbs <- readRDS("test_data/test_lda_gibbs.RDS")
  expect_equal(mean_token_length(lda_gibbs), c(6.1, 5.8, 4.6))
})

# Test CTM VEM model from topicmodels
test_that("CTM VEM", {
  ctm_vem <- readRDS("test_data/test_ctm_vem.RDS")
  expect_equal(mean_token_length(ctm_vem), c(5.2, 7.0, 4.6))
})
