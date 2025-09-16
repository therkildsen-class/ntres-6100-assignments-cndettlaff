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

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = year))
  
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")
#putting the color inside the aes doesn't change the color, put it outside

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class, size = cyl), shape = 1) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
#geo_smooth creates a smooth trendline 

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class, size = cyl), shape = 1) +
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class, size = cyl), shape = 1) +
  geom_smooth() +
  facet_wrap(~ year, nrow = 2) 
#nrow = 2 puts them on top of each other
# the '~' is needed for the facet_wrap, just the way it works

#creating sub-plots for each class
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class)
#splitting by "class", use the facet_wrap to show all graphs by class

#there is a default theme, but can use other themes
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class, size = cyl), shape = 1) +
  geom_smooth() +
  facet_wrap(~ year, nrow = 2) +
  theme_classic()
#play around with different themes using the list from "theme_"





#Data Wrangling with ggplot

ggplot(data=mpg, mapping = aes(x=displ, y=hwy)) +
  geom_point(mapping=aes (color=class, size=cyl), shape=1) +
  geom_smooth() +
  facet_wrap(~year, nrow=2) +
  theme_minimal()

#save the plot with code IOT have a log of what happened and changes happen to the file itself when updated
ggsave(filename = "hwy_vs_displ.png", width = 8, height = 4)



