library(topicmodels)
data("AssociatedPress", package = "topicmodels")

test_that("LDA VEM", {
  lda <- LDA(AssociatedPress[1:20,], method = "VEM",
             k = 3, control = list(seed = 33))
  expect_equal(topic_size(lda), c(3432.904, 3397.258, 3642.838),
               tolerance = 1e-5)
})

test_that("LDA Gibbs", {
  lda <- LDA(AssociatedPress[1:20,], method = "Gibbs",
             k = 3, control = list(seed = 33))
  expect_equal(topic_size(lda), c(3562.351, 3291.167, 3619.483),
               tolerance = 1e-5)
})
