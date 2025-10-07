library(tidyverse)
library(nycflights13)#install.packages("nycflights13")




# Row Binding -------------------------------------------------------------


fship <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv")

ttow <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Two_Towers.csv")

rking <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Return_Of_The_King.csv")

# merging different data sets
lotr <- bind_rows(fship, ttow, rking)

# making it harder by removing a piece of data 
fship_no_female <- fship |> 
  select(-Female, Male, Film, Race)

bind_rows(fship_no_female, ttow, rking)
# the row_bind function matcheds variable names so long as they have the same name



# Join Functions ----------------------------------------------------------

flights # Data Frame
colnames(flights)

airlines
airports

planes |> 
  count(tailnum) |> 
  filter(n > 1)

weather |> 
  count(time_hour, origin) |> 
  filter(n > 1)

# is.na is a good way to see if there is a value of N/A in your data set rather than using "=="
planes |> 
  filter(is.na(tailnum))

flights2 <- flights |> 
  select(year:day, hour, origin, dest, tailnum, carrier)

flights2 |> 
  left_join(airlines)

weather

flights2 |> 
  left_join(weather)

flights2 |> 
  left_join(planes)
# we get N/A's because the variable "year" means something different in the two data sets
# a better way to join 
flights2 |> 
  left_join(planes, join_by(tailnum), suffix = c("_flights", "_plnaes"))
# the suffix specification helps differentiate variables that have the same name

flights2 |> 
  left_join(airports, join_by(origin == faa)) |> 
  left_join(airports, join_by(dest == faa), suffix = c("_origin", "dest"))

airports |> 
  semi_join(flights2, join_by(faa == origin))

# if I want to see if there's any missing data in a data set

flights2 |> 
  anti_join(airports, join_by(dest == faa)) |> 
  distinct(dest)

planes_gt100 <- flights2 |> 
  group_by(tailnum) |> 
  summarise(count = n()) |> 
  filter(count > 100)

planes_gt100 <- flights2 |> 
  count(tailnum) |> 
  filter(n > 100)

flights |> 
  semi_join(planes_gt100)
