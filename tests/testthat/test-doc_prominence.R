# Test LDA VEM model from topicmodels
test_that("LDA VEM", {
  lda_vem <- readRDS("test_data/test_lda_vem.RDS")
  expect_equal(doc_prominence(lda_vem, "gamma_threshold"),
               c(9, 6, 5))
  expect_equal(doc_prominence(lda_vem, "largest_gamma"),
               c(9, 6, 5))
})

# Test LDA Gibbs model from topicmodels
test_that("LDA Gibbs", {
  lda_gibbs <- readRDS("test_data/test_lda_gibbs.RDS")
  expect_equal(doc_prominence(lda_gibbs, "gamma_threshold"),
               c(13, 15, 14))
  expect_equal(doc_prominence(lda_gibbs, "largest_gamma"),
               c(6, 9, 5))
})

# Test CTM VEM model from topicmodels
test_that("CTM VEM", {
  ctm_vem <- readRDS("test_data/test_ctm_vem.RDS")
  expect_equal(doc_prominence(ctm_vem, "gamma_threshold"),
               c(6, 5, 9))
  expect_equal(doc_prominence(ctm_vem, "largest_gamma"),
               c(6, 5, 9))
})
