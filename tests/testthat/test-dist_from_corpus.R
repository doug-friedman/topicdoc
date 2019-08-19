setup(
  data("AssociatedPress", package = "topicmodels")
)

# Test LDA VEM model from topicmodels
test_that("LDA VEM", {
  lda_vem = readRDS("test_data/test_lda_vem.RDS")
  expect_equal(dist_from_corpus(lda_vem, AssociatedPress[1:20,]),
               c(0.5923468, 0.6031025, 0.4972175),
               tolerance = 1e-5)
})

# Test LDA Gibbs model from topicmodels
test_that("LDA Gibbs", {
  lda_gibbs = readRDS("test_data/test_lda_gibbs.RDS")
  expect_equal(dist_from_corpus(lda_gibbs, AssociatedPress[1:20,]),
               c(0.6213969, 0.5870918, 0.6272451),
               tolerance = 1e-5)
})

# Test CTM VEM model from topicmodels
test_that("CTM VEM", {
  ctm_vem = readRDS("test_data/test_ctm_vem.RDS")
  expect_equal(dist_from_corpus(ctm_vem, AssociatedPress[1:20,]),
               c(0.5850700, 0.6024446, 0.4899572),
               tolerance = 1e-5)
})
