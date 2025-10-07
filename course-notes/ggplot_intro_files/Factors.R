library(tidyverse)
library(gapminder)
library(gridExtra) # install.packages("gridExtra")


# Intro Factors -----------------------------------------------------------

x1 <- c("Dec", "Apr", "Jan", "Mar")
x2 <- c("Dec", "Apr", "Jam", "Mar")

month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)

y1 <- factor(x1, levels = month_levels)

sort(y1)

y2 <- factor(x2, levels = month_levels)


# Factors in Plotting -----------------------------------------------------

gapminder

str(gapminder$continent)
levels(gapminder$continent)

gapminder |> 
  count(continent)

nlevels(gapminder$country)

h_countries <- c("Egypt", "Haiti", "Romania", "Thailand", "Venezuela")


h_gap <- gapminder |> 
  filter(country %in% h_countries)

h_gap |> 
  count(country)

nlevels(h_gap$country)

h_gap_drop <- h_gap |> 
  droplevels()


h_gap$country |> 
  fct_drop()



small_country <- gapminder |> 
  filter(pop < 250000) |> 
  droplevels()
  
small_country <- gapminder |> 
  filter(pop < 250000) |> 
  mutate(country = fct_drop(country))

nlevels(small_country$country)




levels(gapminder$continent)

gapminder |> 
  count(continent) |> 
  arrange(-n)

gapminder$continent |> 
  fct_infreq() |> 
  levels()


p1 <- gapminder |> 
  ggplot(aes(x = continent)) +
  geom_bar() +
  coord_flip()


p2 <- gapminder |> 
  ggplot(aes(x = fct_infreq(continent))) +
  geom_bar() +
  coord_flip()


gap_asia_2007 <- gapminder |> 
  filter(year == 2007, continent == "Asia")

gap_asia_2007 |> 
  ggplot(aes(x = lifeExp, y = country)) +
  geom_point()


gap_asia_2007 |> 
  ggplot(aes(x = lifeExp, y = fct_reorder(country, lifeExp))) +
  geom_point()









