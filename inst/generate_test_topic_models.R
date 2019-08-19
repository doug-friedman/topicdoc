# File to generate topic models for each function's set of tests
library(topicmodels)
data("AssociatedPress", package = "topicmodels")

test_data_dir <- file.path("tests", "testthat", "test_data")

lda_vem <- LDA(AssociatedPress[1:20,], method = "VEM",
               k = 3, control = list(seed = 33))

saveRDS(lda_vem, file.path(test_data_dir, "test_lda_vem.RDS"))

lda_gibbs <- LDA(AssociatedPress[1:20,], method = "Gibbs",
                 k = 3, control = list(seed = 33))

saveRDS(lda_gibbs, file.path(test_data_dir, "test_lda_gibbs.RDS"))

ctm_vem <- CTM(AssociatedPress[1:20,], method = "VEM",
               k = 3, control = list(seed = 33))

saveRDS(ctm_vem, file.path(test_data_dir, "test_ctm_vem.RDS"))
