% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/doc_prominence.R
\name{doc_prominence}
\alias{doc_prominence}
\title{Calculate the document prominence of each topic in a topic model}
\usage{
doc_prominence(
  topic_model,
  method = c("gamma_threshold", "largest_gamma"),
  gamma_threshold = 0.2
)
}
\arguments{
\item{topic_model}{a fitted topic model object from one of the following:
\code{\link[topicmodels]{tm-class}}}

\item{method}{a string indicating which method to use -
"gamma_threshold" or "largest_gamma", the default is "gamma_threshold"}

\item{gamma_threshold}{a number between 0 and 1 indicating the gamma threshold to be used
when using the gamma threshold method, the default is 0.2}
}
\value{
A vector of document prominences with length equal to the number of topics in the fitted model
}
\description{
Calculate the document prominence of each topic in a topic model based on either
the number of documents with an estimated gamma probability above a threshold or
the number of documents where a topic has the highest estimated gamma probability
}
\examples{

# Using the example from the LDA function
library(topicmodels)
data("AssociatedPress", package = "topicmodels")
lda <- LDA(AssociatedPress[1:20,], control = list(alpha = 0.1), k = 2)
doc_prominence(lda)
}
\references{
{
  Jordan Boyd-Graber, David Mimno, and David Newman, 2014.
  \emph{Care and Feeding of Topic Models: Problems, Diagnostics, and Improvements.}
  CRC Handbooks ofModern Statistical Methods. CRC Press, Boca Raton, Florida.
}
}
