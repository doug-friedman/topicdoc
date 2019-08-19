
<!-- README.md is generated from README.Rmd. Please edit that file -->

# topicdoc

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.org/doug-friedman/topicdoc.svg?branch=master)](https://travis-ci.org/doug-friedman/topicdoc)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/doug-friedman/topicdoc?branch=master&svg=true)](https://ci.appveyor.com/project/doug-friedman/topicdoc)
[![Codecov test
coverage](https://codecov.io/gh/doug-friedman/topicdoc/branch/master/graph/badge.svg)](https://codecov.io/gh/doug-friedman/topicdoc?branch=master)
<!-- badges: end -->

Like a (good) doctor, the goal of topicdoc is to help diagnose issues
with your topic models through a variety of different diagnostics and
metrics. There are a lot of great R packages for fitting topic models,
but not a lot that help evaluate their fit. This package seeks to fill
that void with functions that easily allow you to run those
diagnostics/metrics efficiently on a variety of topic models.

## Installation

You can install the development version of topicdoc from
[Github](https://www.github.com/doug-friedman/topicdoc) with:

``` r
remotes::install.packages("doug-friedman/topicdoc")
```

## Example

This is a simple use case - using the example model from `LDA` in
`topicmodels`.

``` r
library(topicdoc)
library(topicmodels)

data("AssociatedPress", package = "topicmodels")
lda <- LDA(AssociatedPress[1:20,], control = list(alpha = 0.1), k = 2)

# See the top 10 terms associated with each of the two topics
terms(lda, 10)
#>       Topic 1   Topic 2     
#>  [1,] "percent" "year"      
#>  [2,] "police"  "i"         
#>  [3,] "oil"     "noriega"   
#>  [4,] "million" "bush"      
#>  [5,] "gas"     "president" 
#>  [6,] "peres"   "panama"    
#>  [7,] "mrs"     "campaign"  
#>  [8,] "i"       "magellan"  
#>  [9,] "years"   "spacecraft"
#> [10,] "first"   "national"

# Calculate all diagnostics for each topic in the topic model
topic_diagnostics(lda, AssociatedPress[1:20,])
#>   topic_num topic_size mean_token_length dist_from_corpus
#> 1         1   5161.138               4.5        0.4641428
#> 2         2   5311.862               6.5        0.4320155

# ...or calculate them invidually
topic_size(lda)
#> [1] 5161.138 5311.862
```

## Key References

The following documents provide key references for the
diagnostics/metrics included in the package.

  - [Jordan Boyd-Graber, David Mimno, and David Newman, 2014. Care and
    Feeding of Topic Models: Problems, Diagnostics, and Improvements.
    CRC Handbooks of Modern Statistical Methods. CRC Press, Boca Raton,
    Florida.](http://www.people.fas.harvard.edu/~airoldi/pub/books/b02.AiroldiBleiEroshevaFienberg2014HandbookMMM/Ch12_MMM2014.pdf)
  - [MALLET Topic Model
    Diagnostics](http://mallet.cs.umass.edu/diagnostics.php)
