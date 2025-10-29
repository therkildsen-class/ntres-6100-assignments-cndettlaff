library(tidyverse)
library(gapminder)

# Basic fucntions

calc_shrub_vol <- function(length, width, height) {
  area <- length * width
  volume <- area * height
  return(volume)
}

calc_shrub_vol(0.8, 1.6, 2.0)

convert_pounds_to_grams <- function(pounds) {
  grams <- pounds * 453.592
  return(grams)
}

convert_pounds_to_grams(3.75)

# Default arguments

calc_shrub_vol <- function(length, width, height = 1) {
  area <- length * width
  volume <- area * height
  return(volume)
}

calc_shrub_vol(0.8, 1.6)

est_shrub_mass <- function(volume){
  mass <- 2.65 * volume^0.9
  return(mass)
}

shrub_volume <- calc_shrub_vol(0.8, 1.6, 2.0)
shrub_mass <- est_shrub_mass(shrub_volume)

# For Loop example

gapminder <- gapminder |> 
  rename("life_exp" = lifeExp, "gdp_per_cap" = gdpPercap)


est <- read_csv('https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/countries_estimated.csv')
gapminder_est <- gapminder |> 
  left_join(est)


cntry <- "Belgium"
country_list <- c("Albania", "Canada", "Spain")


dir.create("figures")
dir.create("figures/europe")



gap_europe <- gapminder_est |> 
  filter(continent == "Europe") |> 
  mutate(gdp_tot = gdp_per_cap * pop)

country_list <- unique(gap_europe$country)

length(country_list)

# cntry <- "Albania"

print_plot <- function(cntry, stat = "gdp_per_cap", filetype = "pdf") {
  
  print(str_c("Plotting ", cntry))
  
  gap_to_plot <- gap_europe |> 
    filter(country == cntry)
  
  my_plot <- ggplot(data = gap_to_plot, mapping = aes(x = year, y = get(stat))) +
    geom_point() +
    labs(title = str_c(cntry, "GDP", sep = " "), 
         subtitle = ifelse(any(gap_to_plot$estimated == "yes"), "Estimated data", "Reported data"),
         y = stat)
  
  ggsave(filename = str_c("figures/europe/", cntry, "_", stat, ".", filetype, sep = ""), plot = my_plot)
  
}
print_plot("Germany", "gdp_per_cap")
print_plot("Germany", "life_exp")
print_plot("Germany", "pop")
print_plot("Bulgaria")
# write a for loop to print_plot for each country in country_list
for (cntry in country_list) {
  print_plot(cntry)
}










