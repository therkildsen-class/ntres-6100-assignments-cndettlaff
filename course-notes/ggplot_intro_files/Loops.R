library(gapminder)
library(tidyverse)

gapminder <- gapminder |> 
  rename("life_exp" = lifeExp, "gdp_per_cap" = gdpPercap)

# for (each_item in set_of_items) {
  # do a thing
# }

cntry <- "Afghanistan"
country_list <- c("Iceland", "New Zealand", "Peru")
country_list <- unique(gapminder$country)
length(country_list)

dir.create("figures")

for (cntry in country_list) {

gap_to_plot <- gapminder |> 
  filter(country == cntry)

my_plot <- ggplot(gap_to_plot, mapping = aes(x = year, y = gdp_per_cap)) +
  geom_point() +
  labs(title = str_c(cntry , "GDP per cap"))

ggsave(filename = str_c("figures/", cntry, "_gdp_per_gap.png", sep = ""), plot = my_plot)
}

# In class assignment

euro_country <- unique(gapminder) |> 
  filter(continent == "Europe") |> 
  mutate(gdp_tot = gdp_per_cap * pop)

e_country <- unique(euro_country$country)

dir.create(figures/Europe)

for (e_country in euro_country) {

euro_plot <- euro_country |> 
  filter(country == e_country)
  
my_plot <- ggplot(euro_plot, mapping = aes(x = year, y = gdp_tot)) +
geom_point() +
labs(title = str_c(cntry , "GDP Total"))
ggsave(filename = str_c("figures/", cntry, "_gdp_tot.png", sep = ""), plot = my_plot)
}

# Lecture 16 Oct 21, 2025

# left join to bring in extra variables (use in admissions scritp)

est <- read_csv('https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/countries_estimated.csv')

gapminder_est <- gapminder |> 
  left_join(est)

cntry <- "Belgium"
country_list <- c("Albania", "Canada", "Spain")

dir.create("figures")
dir.create("figures/europe")

country_list <- unique(gapminder$country)

gap_europe <- gapminder |>
  filter(continent == "Europe") |>
  mutate(gdp_tot = gdp_per_cap * pop)

country_list <- unique(gap_europe$country)

length(country_list)



for (cntry in country_list) {
  print(str_c("Plotting ", cntry))
  
  gap_to_plot <- gap_europe |>
    filter(country == cntry)
  
  my_plot <- ggplot(data = gap_to_plot, mapping = aes(x = year, y = gdp_tot)) +
    geom_point() +
    labs(title = str_c(cntry, "GDP", sep = " "))

  if (any(gap_to_plot$estimated == "yes")){
  print(str_c(contry, " data are estimated"))
  my_plot <- my_plot +
    labs(subtitle = "Estimated data")
} else {
  print(str_c(cntry, " data are reported"))
  my_plot <- my_plot +
    labs(subtitle = "Reported data")
  }

  ggsave(filename = str_c("figures/europe/", cntry, "_gdp_tot.png", sep = ""), plot = my_plot)
}


# This does the same thing as the code above
my_plot <- ggplot(data = gap_to_plot, mapping = aes(x = year, y = gdp_tot)) +
  geom_point() +
  labs(title = str_c(cntry, "GDP", sep = " "),
       subtitle = ifelse(any(gap_to_plot$estimated == "yes"), 
                         "Estimated data", "Reported data"))



# new loops

for (i in 1:10) {
  print(i)
}

#///

volumes <- c(1.6, 3, 8)

for (volume in volumes) {
  mass <- 2.65 * volume ^ 0.9
}

# exercise

mass_lbs <- c(2.2, 3.5, 9.6, 1.2)
mass_kg <- vector("numeric", length(mass_lbs))

for (i in seq_along(mass_lbs)) {
  mass_kg[1] = 2.2 / mass_lbs
} # not working



