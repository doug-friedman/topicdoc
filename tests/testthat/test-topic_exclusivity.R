# Test LDA VEM model from topicmodels
test_that("LDA VEM", {
  lda_vem <- readRDS("test_data/test_lda_vem.RDS")
  expect_equal(topic_exclusivity(lda_vem),
               c(9.826199, 1.615042, 1.599136),
               tolerance = 1e-5)
})

# Test LDA Gibbs model from topicmodels
test_that("LDA Gibbs", {
  lda_gibbs <- readRDS("test_data/test_lda_gibbs.RDS")
  expect_equal(topic_exclusivity(lda_gibbs),
               c(9.1934839, 0.9919847, 0.2730874),
               tolerance = 1e-5)
})

# Test CTM VEM model from topicmodels
test_that("CTM VEM", {
  ctm_vem <- readRDS("test_data/test_ctm_vem.RDS")
  expect_equal(topic_exclusivity(ctm_vem),
               c(2.341831, 1.401055, 1.453665),
               tolerance = 1e-5)
})
