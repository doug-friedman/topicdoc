
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

This is a simple use case - using an LDA model with 1992 Associated
Press Dataset in `topicmodels`.

``` r
library(topicdoc)
library(topicmodels)

data("AssociatedPress", package = "topicmodels")
lda <- LDA(AssociatedPress[1:100,], 
           control = list(seed = 33), k = 4)

# See the top 10 terms associated with each of the topics
terms(lda, 10)
#>       Topic 1  Topic 2   Topic 3     Topic 4         
#>  [1,] "people" "percent" "company"   "soviet"        
#>  [2,] "i"      "new"     "bush"      "i"             
#>  [3,] "police" "year"    "new"       "government"    
#>  [4,] "new"    "prices"  "bank"      "people"        
#>  [5,] "city"   "state"   "campaign"  "official"      
#>  [6,] "school" "economy" "percent"   "administration"
#>  [7,] "last"   "two"     "president" "officials"     
#>  [8,] "two"    "rate"    "i"         "year"          
#>  [9,] "years"  "soviet"  "year"      "new"           
#> [10,] "year"   "states"  "rating"    "president"

# Calculate all diagnostics for each topic in the topic model
topic_diagnostics(lda, AssociatedPress[1:100,])
#>   topic_num topic_size mean_token_length dist_from_corpus tf_df_dist
#> 1         1   2700.333               4.2        0.5087536   6.503498
#> 2         2   2595.014               5.1        0.4959252   7.512216
#> 3         3   2479.574               5.3        0.5436225   8.368090
#> 4         4   2698.079               7.0        0.4784405   7.097708
#>   doc_prominence topic_coherence topic_exclusivity
#> 1             26       -75.45836          8.414308
#> 2             30       -89.90897          9.397756
#> 3             22       -96.63925          8.185546
#> 4             25       -69.38898          8.345118

# ...or calculate them individually
topic_size(lda)
#> [1] 2700.333 2595.014 2479.574 2698.079
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
