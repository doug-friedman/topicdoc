library(topicmodels)
data("AssociatedPress", package = "topicmodels")

test_that("LDA VEM", {
  lda <- LDA(AssociatedPress[1:20,], method = "VEM",
             k = 3, control = list(seed = 33))
  expect_equal(mean_token_length(lda), c(5.1, 6.4, 5.3))
})

test_that("LDA Gibbs", {
  lda <- LDA(AssociatedPress[1:20,], method = "Gibbs",
             k = 3, control = list(seed = 33))
  expect_equal(mean_token_length(lda), c(6.1, 5.8, 4.6))
})

test_that("CTM VEM", {
  ctm <- CTM(AssociatedPress[1:20,], method = "VEM",
             k = 3, control = list(seed = 33))
  expect_equal(mean_token_length(ctm), c(5.2, 7.0, 4.6))
})
