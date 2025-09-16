library(tidyverse)
library(skimr) # install.packages("skimr")


coronavirus = read_csv("https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv")
dim(coronavirus)
summary(coronavirus)
skim(coronavirus) # like summary but gives better info
View(coronavirus)
head(coronavirus)
tail(coronavirus)

# pull out one variable
coronavirus$cases


# keep only records that have case counts
filter(coronavirus, cases > 0)

coronavirus_US = filter(coronavirus, country == "US") # quotes becuse "US" is a text string

coronavirus_non_US = filter(coronavirus, country != "US") # any country BUT the US

filter(coronavirus, country == "US" | country == "Canada") # "|" means OR
filter(coronavirus, country %in% c("US", "Canada")) # %in% Includes and c is concatonate

filter(coronavirus, country == "US" & type == "death")  # "&" means AND ("," is the same as &)

# Subset the data to only show the death counts in three European countries on tiday's date in 2021
filter(coronavirus, country %in% c("Switzerland", "Italy", "Hungary") & date == "2021-09-16" & type == "death")

select(coronavirus, date, country, type, cases)
select(coronavirus, -province) #drops just one column

select(coronavirus, lat, long, country) # this is better because it grabs excatly what it typed out
select(coronavirus, 4, 5, 3) # number indexing, but data might get shuffled and misorder what you expect
