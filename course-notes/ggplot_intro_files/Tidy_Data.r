library(tidyverse)
library(skimr)
library(dplyr)
library(ggplot2)


# Wrangling Last Notes ----------------------------------------------------


coronavirus <- read_csv('https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv')


top5_countries <- coronavirus |>
  filter(type == "confirmed") |>
  group_by(country) |>
  summarize(total = sum(cases)) |>
  arrange(-total) |>
  head(5) |>
  pull(country)

coronavirus |> 
  filter(type == "confirmed", country %in% top5_countries, cases >= 0) |> 
  group_by(date, country) |> 
  summarise(total = sum(cases)) |> 
  ggplot() +
  geom_line(mapping = aes(x = date, y= total, color = country)) +
  facet_wrap(~ country)


# Tidy Data ---------------------------------------------------------------

table1

table2

table3

table4a
table4b

table5

table1 |> 
  mutate(rate = cases/population * 10000)

table1 |> 
  group_by(year) |> 
  summarise(total = sum(cases))

table1 |> 
  ggplot(mapping = aes(x = year, y = cases))+
  geom_line()

# annoyingly impossible, clean the data

table2

table2 |> 
  filter(type == "cases",) |> 
  arrange(country)


# Pivot functions ----------------------------------------------------------

table4a_tidy <- table4a |> 
  pivot_longer(c('1999', '2000'), names_to = "Year", values_to = "Cases")
# brings columns together

table4b_tidy <- table4b |> 
  pivot_longer(c('1999', '2000'), names_to = "Year", values_to = "Population")

table2 |> 
  pivot_wider(names_from = type, values_from = count)
# pulls into more columns

table3 |> 
  separate(rate, into = c("cases", "population"))
# or
table3 |> 
  separate(rate, into = c("cases", "population"), sep = "/", convert = TRUE)

table3 |> 
  separate(year, into = c("century", "year"), sep = 2)

table5 <- table3 |> 
  separate(year, into = c("century", "year"), sep = 2)

table5 <- 

# Coronavirus Data --------------------------------------------------------

coronavirus <- read_csv('https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv')







