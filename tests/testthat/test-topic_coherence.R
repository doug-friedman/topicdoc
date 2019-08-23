setup(
  data("AssociatedPress", package = "topicmodels")
)

# Test LDA VEM model from topicmodels
test_that("LDA VEM", {
  lda_vem <- readRDS("test_data/test_lda_vem.RDS")
  expect_equal(topic_coherence(lda_vem, AssociatedPress[1:20,]),
               c(-27.56116, -16.40495, -19.72284),
               tolerance = 1e-5)
})

# Test LDA Gibbs model from topicmodels
test_that("LDA Gibbs", {
  lda_gibbs <- readRDS("test_data/test_lda_gibbs.RDS")
  expect_equal(topic_coherence(lda_gibbs, AssociatedPress[1:20,]),
               c(-15.84011, -23.74777, -30.39344),
               tolerance = 1e-5)
})

# Test CTM VEM model from topicmodels
test_that("CTM VEM", {
  ctm_vem <- readRDS("test_data/test_ctm_vem.RDS")
  expect_equal(topic_coherence(ctm_vem, AssociatedPress[1:20,]),
               c(-38.718883, 7.664312, -38.057321),
               tolerance = 1e-5)
})
