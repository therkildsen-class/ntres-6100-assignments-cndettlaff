# Lab 9


## 

## **Exercise 1: DNA or RNA?**

#### **1.1 Write a function, `dna_or_rna(sequence)`, that determines if a sequence of base pairs is DNA, RNA, or if it is not possible to tell given the sequence provided.**

``` r
dna_or_rna <- function(sequence){
  bases <- str_split(sequence, pattern = "") |> 
    unlist() |> 
    unique()
  if (all(bases %in% c("a", "t", "g", "c")) & "t" %in% bases){
    return("DNA")
  } else if (all(bases %in% c("a", "u", "g", "c")) & "u" %in% bases){
    return("RNA")
 } else {
    return("unknown")
   }
}

dna_or_rna("attggc")
```

    [1] "DNA"

``` r
dna_or_rna("gccaau")
```

    [1] "RNA"

``` r
dna_or_rna("ccagac")
```

    [1] "unknown"

``` r
dna_or_rna("tgcacug")
```

    [1] "unknown"

#### **1.2 Use the `dna_or_rna()` function and a for loop to print the type of the sequences in the following list.**

``` r
sequences = c("ttgaatgccttacaactgatcattacacaggcggcatgaagcaaaaatatactgtgaaccaatgcaggcg", 
              "gauuauuccccacaaagggagugggauuaggagcugcaucauuuacaagagcagaauguuucaaaugcau", 
              "gaaagcaagaaaaggcaggcgaggaagggaagaagggggggaaacc", 
              "guuuccuacaguauuugaugagaaugagaguuuacuccuggaagauaauauuagaauguuuacaacugcaccugaucagguggauaaggaagaugaagacu", 
              "gataaggaagaugaagacutucaggaaucuaauaaaaugcacuccaugaauggauucauguaugggaaucagccggguc")
sequence_type <- vector("character", length(sequences))
for (i in seq_along(sequences)){
  sequence_type[i] <- dna_or_rna(sequences[i])
}
sequence_type
```

    [1] "DNA"     "RNA"     "unknown" "RNA"     "unknown"

#### **1.3 Use the `dna_or_rna()` function and an appropriate map function to print the type of the sequences in the above list.**

``` r
map_chr(sequences, dna_or_rna)
```

    [1] "DNA"     "RNA"     "unknown" "RNA"     "unknown"

#### **1.4 Make your function work with both upper and lower case letters, or even strings with mixed capitalization. Test your function with the following three lines of code:**

``` r
dna_or_rna <- function(sequence){
  bases <- str_split(sequence, pattern = "") %>%
    unlist() %>%
    tolower() %>%
    unique()
  
  if (all(bases %in% c("a", "t", "g", "c")) & "t" %in% bases){
    return("DNA")
  } else if (all(bases %in% c("a", "u", "g", "c")) & "u" %in% bases){
    return("RNA")
  } else {
    return("unknown")
  }
}

dna_or_rna("ATTGGC")
```

    [1] "DNA"

``` r
dna_or_rna("gCCAAu")
```

    [1] "RNA"

``` r
dna_or_rna("ggcacgG")
```

    [1] "unknown"

## **Exercise 2: Rounding**

#### **2.1 To correct this inconsistency issue, write a custom function that consistently applies a [round half away from zero rule](https://en.wikipedia.org/wiki/Rounding#Round_half_away_from_zero).**

``` r
round_away <- function(x, digits = 0) {
  # Move the decimal to the right according to the digits argument
  x_new <- abs(x * 10^digits)
  
  # Determine the sign of x (1 for positive, -1 for negative, 0 for zero)
  x_sign <- sign(x)
  
  # Separate integer and decimal parts
  integer <- x_new %/% 1
  decimal <- x_new - integer
  
  # Apply "round half away from zero" rule
  if (decimal < 0.5) {
    x_new <- integer
  } else {
    x_new <- integer + 1
  }
  
  # Move the decimal back to the original position and reapply the sign
  x_rounded <- x_new / 10^digits * x_sign
  
  return(x_rounded)
}
```

#### **2.2 Now, building on the previous question, write a custom function that consistently applies a round half to even rule when rounding off a 5.**

``` r
round_even <- function(x, digits = 0) {
  # Step 1: Shift the decimal point
  x_new <- abs(x * 10^digits)
  
  # Step 2: Store the sign of x (1, -1, or 0)
  x_sign <- sign(x)
  
  # Step 3: Separate integer and decimal parts
  integer <- x_new %/% 1
  decimal <- x_new - integer
  
  # Step 4: Apply the "round half to even" rule
  if (decimal < 0.5) {
    x_new <- integer
  } else if (decimal == 0.5) {
    # If the integer part is even, keep it; if odd, round up
    if (integer %% 2 == 0) {
      x_new <- integer
    } else {
      x_new <- integer + 1
    }
  } else {
    x_new <- integer + 1
  }
  
  # Step 5: Shift decimal back and reapply the sign
  x_rounded <- x_new / 10^digits * x_sign
  return(x_rounded)
}
```
