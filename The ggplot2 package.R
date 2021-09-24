#########################################################################
#ggplot2 package in the TIDYVERSE for visualization using gapminder data
#########################################################################

library(tidyverse)
library(dslabs)
data(gapminder)

#explore the data
head(gapminder)
str(gapminder)


#plot a graph of life expectancy vs fertility rate in the continents in 2005.
# life expectancy and fertility rates
filter(gapminder, year == 2005) %>%
  ggplot(aes(fertility, life_expectancy, color = continent)) +
  geom_point()+
  labs(title = "Life Expectancy VS Fertility Rate in 2005")

#Compare life expectancy vs fertility between 1962 and 2012
#faceting by year only
filter(gapminder, year %in% c(1962,2012)) %>%
  ggplot(aes(fertility, life_expectancy, color = continent)) +
  geom_point() +
  facet_grid(. ~year)+
  labs(title = "Life Expectancy VS Fertility Rate in 1962 and 2012")

#facet by year, plots wrapped in multiple rows
years <- c(1962, 1980,1990,2000, 2012)
continents <- c("Europe", "Asia")
gapminder %>%
  filter(year %in% years & continent %in% continents) %>%
  ggplot(aes(fertility, life_expectancy, color = continent)) +
  geom_point() +
  facet_wrap(~year)


################################################################
#Time series plots
################################################################
#scatter plot for US Fertility over the years in the United states.
gapminder %>%
  filter(country == "United States") %>%
  ggplot(aes(year, fertility))+
  geom_line()

#multiple time series
#scatter plot for US Fertility over the years in South Korea and Germany
countries <- c("South Korea", "Germany")
gapminder %>%
  filter(country %in% countries) %>%
  ggplot(aes(year, fertility))+
  geom_line()


#multiple time series showed two with legend
countries <- c("South Korea", "Germany")
gapminder %>%
  filter(country %in% countries) %>%
  ggplot(aes(year, fertility, color = country))+
  geom_line()



#adding text labels to a plot
countries <- c("South Korea", "Germany")
labels <- data.frame(country = countries, x = c(1975,1965), y = c(60,72))
gapminder %>%
  filter(country %in% countries) %>%
  ggplot(aes(year, life_expectancy, color = country)) +
  geom_line()+
  geom_text(data = labels, aes(x,y, label = country), size = 5)+
  theme(legend.position = "None")

#add dollars per day variable 
gapminder <- gapminder %>% 
  mutate(dollars_per_day = gdp/population/365)
gapminder

##################################################################
#histogram
##################################################################
#histogram for dollars per day
past_year <- 1970
gapminder %>%
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes((dollars_per_day)))+
  geom_histogram(binwidth = 1, color = "black")+
  scale_x_continuous(trans = "log2")


###################################################################
#Boxplots
###################################################################
#create a box plot showing dollars per day in different regions in 1970
p <- gapminder %>%
  filter(year == past_year & !is.na(gdp)) %>%
  ggplot(aes(region, dollars_per_day))

p +  geom_boxplot() +
theme(axis.text.x = element_text(angle =90, hjust = 1))




#reorder function
p <- gapminder %>%
  filter(year == past_year & !is.na(gdp)) %>%
  mutate(region = reorder(region, dollars_per_day, FUN = median)) %>%
  ggplot(aes(region, dollars_per_day, fill = continent)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle =90, hjust = 1)) +
  xlab("")
p
p + scale_y_continuous(trans = "log2")+
  geom_point(show.legend = FALSE)



#################################################################
#comparing distributions using histograms
##################################################################
west <- c("Western Europe", "Northern Europe", "Southern Europe",
          "Northern America", "Australia and New Zealand")

#Facet by West vs Developing nations in 1970
gapminder %>%
  filter(year == past_year & !is.na(gdp)) %>%
  mutate(group = ifelse(region %in% west, "West", "Developing")) %>%
  ggplot(aes(dollars_per_day)) +
  geom_histogram(binwidth =1, color = "black") +
  scale_x_continuous(trans = "log2") +
  facet_grid(.~ group)



#comparing by faceting both year and region. we've got two years
present_year <- 2010
gapminder %>%
  filter(year %in% c(past_year, present_year) & !is.na(gdp)) %>%
  mutate(group = ifelse(region %in% west, "West", "Developing")) %>%
  ggplot(aes(dollars_per_day)) +
  geom_histogram(binwidth = 1, color = "black") +
  scale_x_continuous(trans = "log2")+
  facet_grid(year~group)

#west Vs Developing where both groups have data in 1970 and 2010
country_list_1 <- gapminder %>%
  filter(year == past_year & !is.na(dollars_per_day)) %>%
  .$country
country_list_1

country_list_2 <- gapminder %>%
  filter(year == present_year & !is.na(dollars_per_day)) %>% .$country
country_list_2

country_list <- intersect(country_list_1, country_list_2)
country_list

#make a histogram with data available in both years

gapminder %>%
  filter(year %in% c(past_year, present_year) & country %in% country_list) %>%
  mutate(group = ifelse(region %in% west, "West", "Developing")) %>%
  ggplot(aes(dollars_per_day)) +
  geom_histogram(binwidth = 1, color = "black") +
  scale_x_continuous(trans = "log2")+
  facet_grid(year ~ group)

#using boxplots to compare the regions in 1970 and 2010.
p <- gapminder %>%
  filter(year %in% c(past_year, present_year) & country %in% country_list) %>%
  mutate(region = reorder(region, dollars_per_day, FUN = median)) %>%
  ggplot() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  xlab("") +
  scale_y_continuous(trans = "log2")

p + geom_boxplot(aes(region, dollars_per_day, fill = continent))+
  facet_grid(year~.)

p + geom_boxplot(aes(region, dollars_per_day, fill = factor(year)))


####################################################################
#smooth density plots
####################################################################
p <- gapminder %>%
  filter(year %in% c(past_year, present_year) & country %in% country_list) %>%
  mutate(group = ifelse(region %in% west, "West", "Developing")) %>%
  ggplot(aes(dollars_per_day, y = ..count.., fill= group)) +
  scale_x_continuous(trans = "log2")
p + geom_density(alpha = 0.2, bw = 0.75)+
  facet_grid(year~.)




#using case_when
gapminder <- gapminder %>%
  mutate(group = case_when(
    .$region %in% west ~ "west",
    .$region %in% c("Eastern Asia", "South Eastern Asia") ~ "East Asia",
    .$region %in% c("Caribbean", "Central America", "South America") ~ "Latin America",
    .$continent == "Africa" & .$region != "Northern Africa" ~ "Sub-Saharan Africa",
    TRUE ~ "Others"))


#reorder factor levels
gapminder <- gapminder %>%
  mutate(group = factor(group, levels = c("Others", "Latin America", "East Asia", "Sub-Saharan Africa", "west")))

p <- gapminder %>%
  filter(year %in% c(past_year, present_year) & country %in% country_list) %>%
  ggplot(aes(dollars_per_day, fill = group))+
  scale_x_continuous(trans = "log2")

p + geom_density(alpha = 0.2, bw = 0.75, position = "stack")+
  facet_grid(year~.)








