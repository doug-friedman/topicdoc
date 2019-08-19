setup(
  data("AssociatedPress", package = "topicmodels")
)

# Test LDA VEM model from topicmodels
test_that("LDA VEM", {
  lda_vem <- readRDS("test_data/test_lda_vem.RDS")
  expect_equal(tf_df_dist(lda_vem, AssociatedPress[1:20,]),
               c(4.055438, 4.438195, 5.530468),
               tolerance = 1e-5)
})

# Test LDA Gibbs model from topicmodels
test_that("LDA Gibbs", {
  lda_gibbs <- readRDS("test_data/test_lda_gibbs.RDS")
  expect_equal(tf_df_dist(lda_gibbs, AssociatedPress[1:20,]),
               c(4.597900, 4.848519, 4.244845),
               tolerance = 1e-5)
})

# Test CTM VEM model from topicmodels
test_that("CTM VEM", {
  ctm_vem <- readRDS("test_data/test_ctm_vem.RDS")
  expect_equal(tf_df_dist(ctm_vem, AssociatedPress[1:20,]),
               c(4.690659, 4.514835, 5.042842),
               tolerance = 1e-5)
})
