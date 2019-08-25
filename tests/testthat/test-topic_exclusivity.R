# Test LDA VEM model from topicmodels
test_that("LDA VEM", {
  lda_vem <- readRDS("test_data/test_lda_vem.RDS")
  expect_equal(topic_exclusivity(lda_vem),
               c(9.826199, 9.856268, 9.779687),
               tolerance = 1e-5)
})

# Test LDA Gibbs model from topicmodels
test_that("LDA Gibbs", {
  lda_gibbs <- readRDS("test_data/test_lda_gibbs.RDS")
  expect_equal(topic_exclusivity(lda_gibbs),
               c(9.193484, 9.963191, 9.933647),
               tolerance = 1e-5)
})

# Test CTM VEM model from topicmodels
test_that("CTM VEM", {
  ctm_vem <- readRDS("test_data/test_ctm_vem.RDS")
  expect_equal(topic_exclusivity(ctm_vem),
               c(2.341831, 2.627743, 2.163173),
               tolerance = 1e-5)
})
