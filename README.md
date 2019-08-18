
<!-- README.md is generated from README.Rmd. Please edit that file -->

# topicdoc

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.org/doug-friedman/topicdoc.svg?branch=master)](https://travis-ci.org/doug-friedman/topicdoc)
[![Codecov test
coverage](https://codecov.io/gh/doug-friedman/topicdoc/branch/master/graph/badge.svg)](https://codecov.io/gh/doug-friedman/topicdoc?branch=master)
<!-- badges: end -->

Like a (good) doctor, the goal of topicdoc is to help diagnose issues
with your topic models through a variety of different diagnostics and
metrics. There are a lot of great R packages for fitting topic models,
but not a lot that help evaluate their fit. This package seeks to fill
that void with functionality that easily allow you to run those
diagnostics/metrics efficiently on a variety of topic models.

## Installation

You can install the development version of topicdoc from
[Github](https://www.github.com/doug-friedman/topicdoc) with:

``` r
remotes::install.packages("doug-friedman/topicdoc")
```

## Example

This is a basic use case - using the example model from `LDA` in
`topicmodels`.

``` r
library(topicdoc)
library(topicmodels)

data("AssociatedPress", package = "topicmodels")
lda <- LDA(AssociatedPress[1:20,], control = list(alpha = 0.1), k = 2)

# See the top 10 terms associated with each of the two topics
terms(lda, 10)
#>       Topic 1    Topic 2  
#>  [1,] "i"        "percent"
#>  [2,] "police"   "oil"    
#>  [3,] "year"     "million"
#>  [4,] "noriega"  "gas"    
#>  [5,] "bush"     "peres"  
#>  [6,] "people"   "first"  
#>  [7,] "panama"   "year"   
#>  [8,] "campaign" "rose"   
#>  [9,] "get"      "years"  
#> [10,] "magellan" "rate"

# Calculate the size (or fractional number of tokens) associated with each topic
topic_size(lda)
#> [1] 5374.698 5098.302

# Calculate the mean token length associated with each topic
mean_token_length(lda)
#> [1] 5.3 4.7
```

## Key References

The following documents provide key references for the
diagnostics/metrics included in the package.

  - [Jordan Boyd-Graber, David Mimno, and David Newman, 2014. Care and
    Feeding of Topic Models: Problems, Diagnostics, and Improvements.
    CRC Handbooks ofModern Statistical Methods. CRC Press, Boca Raton,
    Florida.](http://www.people.fas.harvard.edu/~airoldi/pub/books/b02.AiroldiBleiEroshevaFienberg2014HandbookMMM/Ch12_MMM2014.pdf)
  - [MALLET Topic Model
    Diagnostics](http://mallet.cs.umass.edu/diagnostics.php)
