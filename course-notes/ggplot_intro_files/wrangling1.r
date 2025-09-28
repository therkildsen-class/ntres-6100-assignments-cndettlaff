library(tidyverse)
library(skimr) # install.packages("skimr")
library(ggplot2)

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



select(coronavirus, contains("y"), everything())
# everything keeps all the columns when you select specific columns to be first

coronoavirus_us <-  filter(coronavirus, country == "US")
coronavirus_us2 <- select(coronoavirus_us, -province, -lat, -long)

# pipe operator = "shift + command + m"
coronavirus |> 
  filter(country == "US") |> 
  select(- lat, -long, -province)

coronavirus |> 
  count(country) |> 
  view()

# use piping to streamline functionality
coronavirus |> 
  filter(type == "death", country %in% c("US", "Canada", "Mexico")) |> 
  select(country, date, cases) |> 
  ggplot() +
  geom_line(mapping = aes(x = date, y = cases, color = country))


# Vaccine Data ------------------------------------------------------------

vacc <- read_csv("https://raw.githubusercontent.com/RamiKrispin/coronavirus/main/csv/covid19_vaccine.csv")
View(vacc)

# mutate() function
vacc |> 
  filter(date == max(date)) |> 
  select(country_region, continent_name, people_at_least_one_dose, population) |> 
  mutate(vaxrate = round(people_at_least_one_dose/population, 2))
# mutate object    variable(s) you want to mutate


# exercise 2
vacc |> 
  filter(date == max(date)) |> 
  select(country_region, continent_name, doses_admin, people_at_least_one_dose, population) |> 
  mutate(doses_per_vax = doses_admin/people_at_least_one_dose) |> 
  filter(doses_per_vax > 3) |> 
  arrange(-doses_per_vax)

#exercise 3
vacc |> 
  filter(date == max(date)) |> 
  select(country_region, continent_name, doses_admin, people_at_least_one_dose, population) |> 
  mutate(most_pop_dose = people_at_least_one_dose/population) |> 
  filter(most_pop_dose > 0.90) |> 
  arrange(-most_pop_dose) |> 
  head()




# Summary -----------------------------------------------------------------


# Summarize Function ------------------------------------------------------

# using summarize function
coronavirus |> 
  filter(type == "confirmed") |> 
  group_by(country) |> 
  summarize(total = sum(cases),
            n = n()) |> 
  arrange(-total)

coronavirus |> 
  group_by(date, type) |> 
  summarise(total = sum(cases)) |> 

# Which day has had the highest total death count globally reported in this dataset?
# Pipe your global daily death counts into ggplot to visualize the trend over time.
coronavirus |> 
  filter(type == "death") |> 
  group_by(date) |> 
  summarise(death_tot = sum(cases)) |> 
  arrange(-death_tot) |> 
  ggplot(aes(x = date, y = death_tot)) +
  geom_point() +
  geom_smooth()

gg_base <- coronavirus |> 
  filter(type == "confirmed") |> 
  group_by(date) |> 
  summarise(total_cases = sum(cases)) |> 
  ggplot(aes(x = date, y = total_cases))

gg_base +
  geom_line(
    color = "purple",
    linetype = "dashed"
  )

gg_base +
  geom_point(mapping = aes(size = total_cases),
             color = "darkgreen",
             shape = 20,
             alpha = 0.7) +
  geom_smooth(color ="tomato")




gg_base +
  geom_point(mapping = aes(size = total_cases, color = total_cases),
             alpha = 0.4) +
  theme_minimal() +
  labs(
    x = "Date",
    y = "Total confirmed cases",
    title = str_c("Daily Counts of New Coronavirus Cases ", max(coronavirus$date)),
    subtitle = "Global Sums"
  )

#Split the case counts by country

coronavirus |> 
  filter(type == "confirmed") |> 
  group_by(country, date) |> 
  summarise(total_cases = sum(cases)) |> 
  ggplot() +
  geom_line(mapping = aes(x = date, y = total_cases, color = country))


coronavirus |> 
  filter(type == "confirmed") |> 
  group_by(country) |> 
  summarise(total = sum(cases)) |> 
  arrange(-total) |> 
  head(5) |> 
  pull(country)
