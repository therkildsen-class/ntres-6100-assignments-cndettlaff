library(palmerpenguins)
library(tidyverse)

# Load the penguins dataset
glimpse(penguins)
view(penguins)

# visualize bill length by species
ggplot(penguins, aes(x = species, y = bill_length_mm, color = species)) +
  geom_boxplot() +
  geom_jitter(width = 0.2, alpha = 0.5) +
  labs(title = "Bill Length by Penguin Species",
       x = "Species",
       y = "Bill Length (mm)") +
  theme_minimal()

# visualize body mass by flippier length and sex taking out NA values
penguins <- penguins |> drop_na(sex)
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g , color = species, shape = sex)) +
  geom_point() +
  labs(title = "Body Mass vs Flipper Length by Sex",
       x = "Flipper Length (mm)",
       y = "Body Mass (g)") +
  theme_minimal() +
  facet_wrap(~species) +
  scale_color_brewer(palette = "Set1")


library(gapminder)
library(knitr)
library(janitor)

head(gapminder)
gapminder_clean <- gapminder |> 
  clean_names()
glimpse(gapminder_clean)

# create a plot of gdp per cap vs year for each country use for loops and ggsave
unique_countries <- unique(gapminder_clean$country)
for (country in unique_countries) {
  country_data <- gapminder_clean |> filter(country == !!country)
  
  p <- ggplot(country_data, aes(x = year, y = gdp_percap)) +
    geom_line(color = "blue") +
    geom_point() +
    labs(title = paste("GDP per Capita over Time in", country),
         x = "Year",
         y = "GDP per Capita") +
    theme_minimal()
  
  ggsave(filename = paste0("gdp_per_capita_", gsub(" ", "_", country), ".png"), plot = p)
}
