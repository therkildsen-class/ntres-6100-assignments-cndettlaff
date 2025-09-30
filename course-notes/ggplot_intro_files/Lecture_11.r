library(tidyverse)
library(readxl)#install.packages("readxl")
library(googlesheets4)#install.packages("googlesheets4")
library(janitor)#install.packages("janitor")

lotr <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/lotr_tidy.csv")

# How to save a file on local machine
write_csv(lotr, "Data/lotr.csv")

lotr <- read_csv("Data/lotr.csv")

# Reading from Excel

lotr <- read_xlsx("Data/data_lesson11.xlsx", sheet = "FOTR")

# Reading from a Google Sheet

lotr_google <- read_sheet("https://docs.google.com/spreadsheets/d/1X98JobRtA3JGBFacs_JSjiX-4DPQ0vZYtNl_ozqF6IE/edit#gid=754443596", 
           sheet = "deaths", range = "A5:F15")
gs4_deauth()
           
# New Slack dataset

msa <- read_tsv("https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/main/datasets/janitor_mymsa_subset.txt")
colnames(msa)
# package that cleans us messy lables -> janitor, clean_names()
msa_clean <- clean_names(msa)
