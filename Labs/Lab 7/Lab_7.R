library(tidyverse)
library(ggplot2)
library(dplyr)
library(knitr)
library(nycflights13)
library(babynames)

flights |> head() |> kable()

# Question 1: Compute the average delay by destination, then join on the airports data frame 
# you can show the spatial distribution of delays. Here’s an easy way to draw a map of the 
# United States:

library(maps) #install.packages("maps")

airports |>
  semi_join(flights, c("faa" = "dest")) |>
  ggplot(aes(lon, lat)) +
  borders("state") +
  geom_point() +
  coord_quickmap()

avg_delay <- flights |> 
  group_by(dest) |> 
  summarise(delay = mean(arr_delay, na.rm = TRUE)) |> 
  inner_join(airports, by = c(dest = "faa"))

avg_delay |> 
  ggplot(aes(lon, lat, color = delay)) +
  borders("state") + 
  geom_point() + 
  coord_quickmap()

#Question 2: Is there a relationship between the age of a plane and its delays?

age_delay <- inner_join(flights,
                        select(planes, tailnum, year),
                        by = "tailnum",
                        suffix = c("_flight", "_plane")) |> 
  mutate(age = year_flight - year_plane) |> 
  filter(!is.na(age)) |> 
  mutate(age = if_else(age > 25, 25L, age)) |> 
  group_by(age) |> 
  summarise(
    dep_delay_mean = mean(dep_delay, na.rm = TRUE),
    arr_delay_mean = mean(arr_delay, na.rm = TRUE)
  )

ggplot(age_delay, aes(x = age, y = dep_delay_mean)) +
  geom_point()


# Question 3: What weather conditions make it more likely to see a delay?

weather_condition <- 
  flights |> 
  inner_join(weather, by = c("origin", "year", "month", "day", "hour"))

weather_condition |> 
  group_by(precip) |> 
  summarise(delay = mean(dep_delay, na.rm = TRUE)) |> 
  ggplot(aes(x = precip, y = delay)) +
  geom_line() +
  geom_point()

# Exercise 2
# Question 1: What are the 6 most popular boy names and girl names of all time? 
# How has the popularity of each of these names changed over time? 
# This time, use the slice_max() function in combination with a join function to answer this question.

top_6_bn <- babynames |> 
  group_by(sex, name) |> 
  summarise(total_count = sum(n)) |> 
  ungroup() |> 
  group_by(sex) |> 
  slice_max(order_by = total_count, n = 6)

babynames |> 
  semi_join(top_6_bn, by = c("sex", "name")) |> 
  ggplot(aes(x = year, y = prop, group = name, color = sex)) +
  geom_line() +
  facet_wrap(~name)


# Question 2. Find the names that have not appeared in this dataset until 2010, 
# but were used more than 1000 times 2010-2017 (boys and girls combined). 
# Do you recognize any pop culture influence in these?




new_age_names <- babynames |> 
  mutate(threshold = ifelse(year >= 2010, "after", "before")) |> 
  group_by(name, threshold) |> 
  summarise(total_count = sum(n)) |> 
  pivot_wider(names_from = threshold, values_from = total_count, names_prefix = "count_") |> 
  mutate_all(~replace(., is.na(.), 0)) |> 
  filter(count_before == 0, count_after >= 1000)

new_age_names |> 
  kable()

# Question 3. Find the 12 most popular unisex names. 
# How have the proportion of girls for each of them changed over time?

unisex_names <- babynames |>
  group_by(name, sex) |>
  summarise(total_count = sum(n)) |>
  pivot_wider(names_from = sex, values_from = total_count, names_prefix = "count_") |>
  filter(!is.na(count_M), !is.na(count_F)) |>
  mutate(total_count=count_M+count_F, f_proportion = count_F / total_count) |>
  filter(f_proportion<0.9, f_proportion>0.1) |>
  arrange(-total_count)

unisex_names |>
  head(12) |>
  kable()

unisex_names |>
  head(12) |>
  ggplot(aes(x=count_M, y=count_F)) +
  geom_label(aes(label=name)) +
  geom_point(data=unisex_names, cex = 0.5)

babynames |>
  filter(name %in% unisex_names$name[1:12]) |>
  pivot_wider(names_from = sex, values_from = c(n, prop)) |>
  mutate_all(~replace(., is.na(.), 0)) |>
  mutate(total_count=n_F+n_M, f_proportion = n_F / total_count, average_popularity = (prop_F + prop_M)/2) |>
  ggplot(aes(year, f_proportion, group=name)) +
  geom_line() +
  geom_point(aes(size = average_popularity)) +
  facet_wrap(~name) +
  ylab("proportion of girls")





