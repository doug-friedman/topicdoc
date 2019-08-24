
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
lda <- LDA(AssociatedPress[1:20,], 
           control = list(alpha = 0.1), k = 2)

# See the top 10 terms associated with each of the two topics
terms(lda, 10)
#>       Topic 1     Topic 2     
#>  [1,] "i"         "percent"   
#>  [2,] "noriega"   "year"      
#>  [3,] "bush"      "peres"     
#>  [4,] "american"  "rose"      
#>  [5,] "panama"    "magellan"  
#>  [6,] "president" "spacecraft"
#>  [7,] "campaign"  "won"       
#>  [8,] "gas"       "contact"   
#>  [9,] "million"   "national"  
#> [10,] "mrs"       "november"

# Calculate all diagnostics for each topic in the topic model
topic_diagnostics(lda, AssociatedPress[1:20,])
#>   topic_num topic_size mean_token_length dist_from_corpus tf_df_dist
#> 1         1    5288.51               5.6        0.4320950   5.075092
#> 2         2    5184.49               6.4        0.4521169   4.920845
#>   doc_prominence topic_coherence topic_exclusivity
#> 1             10       -32.03121          9.730043
#> 2             10       -39.75965          0.841754

# ...or calculate them individually
topic_size(lda)
#> [1] 5288.51 5184.49
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
