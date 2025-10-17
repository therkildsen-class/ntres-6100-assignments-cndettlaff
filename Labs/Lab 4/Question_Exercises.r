library(tidyverse)
library(dslabs) #install.packages("dslabs")


# taking a look at the data
gapminder |> as_tibble() |> 
  head(5)
dim(gapminder)
colnames(gapminder)
?gapminder

# Question 1: Which five countries had the largest population size in 2015 
# (the most recent year for which population sizes are included in this dataset), 
# and how has the population sizes in those countries changes since 1960?

top5_countries <- gapminder |> 
  filter(year == 2015) |> 
  arrange(-population) |>
  select(country) |> 
  head(5) |> 
  pull()
# answer: 1) China, 2) India, 3) US, 4) Indonesia, 5) Brazil

#create ggplot
gapminder |> 
  filter(country %in% top5_countries) |> 
  ggplot() +
  geom_line(mapping = aes(x = year, y = population, color = country))

# Question 2:  Rank the following countries in infant mortality rate in 2015.
# Turkey, Poland, South Korea, Russia, Vietnam, South Africa

inf_mortality_rank <- gapminder |> 
  filter(country %in% c("Turkey", "Poland", "South Korea", "Russia", "Vietnam", "South Africa"), year == 2015) |> 
  arrange(infant_mortality) |> 
  select(country, infant_mortality)

# Question 3: What is the general relationship between per-capita GDP and fertility rate?
# B. Negative relationship
 
gapminder |> 
  filter(year == 2000) |> 
  ggplot(mapping = aes(x = gdp/population, y = fertility)) +
  geom_point() +
  geom_smooth(method = lm, se = F)

# Question 4: If you break down the relationship between per-capita GDP and fertility rate by continent, 
# which continent (or regions) stands out as an outlier? (Bonus question: why might this be?)
# C. Europe

gapminder |> 
  filter(year == 2000) |> 
  ggplot(aes(y = fertility, x = gdp/population, color = continent)) +
  geom_point() +
  geom_smooth(se = F, method = lm) +
  facet_wrap(~continent, scales = "free_y")

eu_2000 <- gapminder |> 
  filter(year == 2000, continent == "Europe")

eu_2000 |> 
  ggplot(aes(x = gdp/population, y = fertility, color = region)) +
  geom_point()
  
# Question 5:  There are roughly seven billion people in the world today. Which map shows where people live?
# Map A

# group population by continent
gapminder |> 
  filter(year == 2015) |> 
  group_by(continent) |> 
  summarize(population_in_billion = sum(population/10^9)) |> 
  ggplot(aes(x = continent, y = population_in_billion)) +
  geom_col()
  

# Question 6: What is the overall life expectancy for the world population (i.e. global average)?
# 72. 2457 years

gapminder |> 
  filter(year == 2015) |> 
  summarise(life_expectancy <- sum((life_expectancy * population)/sum(population)))

# Question 7: What is the gap in life expectancy between Europe and Africa?
# C. 25 years

gapminder |>
  filter(year==2015) |>
  group_by(continent) |>
  summarize(life_expectancy=sum(life_expectancy*population)/sum(population)) |>
  ggplot(aes(x=continent, y=life_expectancy)) +
  geom_col()

gapminder |>
  filter(year==2015) |>
  ggplot(aes(x=continent, y=life_expectancy)) +
  geom_jitter(aes(color=continent),height = 0) +
  geom_boxplot(alpha=0, outlier.alpha = 0)




