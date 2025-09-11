library(tidyverse)

mpg
?mpg

?cars
cars

View(mpg)

head(cars, 4)
tail(cars)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class, size = cyl), shape = 1)
