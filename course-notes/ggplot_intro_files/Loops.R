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

e_country <- unique(euro_contry$country)

dir.create(figures/Europe)

for (e_country in euro_country) {

euro_plot <- euro_country |> 
  filter(country == e_country)
  
my_plot <- ggplot(euro_plot, mapping = aes(x = year, y = gdp_tot)) +
geom_point() +
labs(title = str_c(cntry , "GDP Total"))
ggsave(filename = str_c("figures/", cntry, "_gdp_tot.png", sep = ""), plot = my_plot)
}

