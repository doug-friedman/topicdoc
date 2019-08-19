# Test LDA VEM model from topicmodels
test_that("LDA VEM", {
  lda_vem <- readRDS("test_data/test_lda_vem.RDS")
  expect_equal(topic_size(lda_vem), c(3432.904, 3397.258, 3642.838),
               tolerance = 1e-5)
})

# Test LDA Gibbs model from topicmodels
test_that("LDA Gibbs", {
  lda_gibbs <- readRDS("test_data/test_lda_gibbs.RDS")
  expect_equal(topic_size(lda_gibbs), c(3562.351, 3291.167, 3619.483),
               tolerance = 1e-5)
})

# Test CTM VEM model from topicmodels
test_that("CTM VEM", {
  ctm_vem <- readRDS("test_data/test_ctm_vem.RDS")
  expect_equal(topic_size(ctm_vem), c(589.6001, 529.5149, 708.8850),
               tolerance = 1e-5)
})
