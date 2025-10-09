# Assignment 6


    ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ✔ dplyr     1.1.4     ✔ readr     2.1.5
    ✔ forcats   1.0.0     ✔ stringr   1.5.1
    ✔ ggplot2   4.0.0     ✔ tibble    3.3.0
    ✔ lubridate 1.9.4     ✔ tidyr     1.3.1
    ✔ purrr     1.1.0     
    ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ✖ dplyr::filter() masks stats::filter()
    ✖ dplyr::lag()    masks stats::lag()
    ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

## Exercise 1. Tibble and Data Import

1.1

``` r
tribble(
  ~a, ~b, ~c,
  #--|--|----
  1, 2.1, "apple",
  2, 3.2, "orange"
)
```

    # A tibble: 2 × 3
          a     b c     
      <dbl> <dbl> <chr> 
    1     1   2.1 apple 
    2     2   3.2 orange

``` r
tibble(
  a = 1:2,
  b = 2.1:3.2,
  c = c("apple", "orange")
)
```

    # A tibble: 2 × 3
          a     b c     
      <int> <dbl> <chr> 
    1     1   2.1 apple 
    2     2   3.1 orange

1.2

``` r
data2 <- read.csv("https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/dataset2.txt",
                  header = FALSE)
colnames(data2) <- c("Name", "Weight", "Price")
data2
```

        Name Weight Price
    1  apple      1   2.9
    2 orange      2   4.9
    3 durian     10  19.9

1.3

``` r
data3 <- read.csv("https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/master/datasets/dataset3.txt",
                   header = TRUE,   # There's a header line after the metadata
  sep = ";",               # Columns separated by semicolons
  quote = "/",             # Text enclosed in slashes
  na.strings = c("?", "Not Available"),  # Handle missing values
  skip = 2,                # Skip first two metadata lines
  stringsAsFactors = FALSE
)
data3
```

        Name Weight Price
    1  apple      1   2.9
    2 orange      2    NA
    3 durian     NA  19.9
