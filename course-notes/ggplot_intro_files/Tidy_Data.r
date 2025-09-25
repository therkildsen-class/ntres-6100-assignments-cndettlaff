library(tidyverse)
library(skimr)
library(dplyr)
library(ggplot2)
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
