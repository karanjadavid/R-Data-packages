###################################################################
    #Dissecting Penguins data set with dplyr
###################################################################
#dplyr is in the tidyverse package.

# load the tidyverse
library(tidyverse)
library(janitor)

#import the data set
penguins <- read_csv("penguins_lter.csv")


#Check out the data
View(penguins)
glimpse(penguins)
summary(penguins)
names(penguins)

#make column names consistent
penguins <- clean_names(penguins)
names(penguins)


#Exploring the data
####################################################
#filter function
####################################################
#find penguins living in Torgersen island
penguins %>% 
  filter(island == "Torgersen")

#filter penguins with a culmen length less than 38mm
penguins %>% 
  filter(culmen_length_mm <38)

#filter penguins with a culmen length between 38.5 and 47.5mm
penguins %>% 
  filter(between(culmen_length_mm, 38.5,47.5))

##################################################
    #arrange
##################################################
#arrange sorts the data. Both numeric and characters

#arrange function displays data in ascending order
penguins %>% 
  arrange(sample_number)

#nesting desc inside arrange orders the data in descending order
penguins %>% 
  arrange(desc(sample_number))

###################################################
       #select
###################################################
#select enables us to select only the data we need 

#For instance we can select 3 columns that we need.
penguins %>% 
  select(sample_number,species,island)

#You can use select to choose specific data types. 
#Suppose you want to see and work with only numeric data
penguins %>% 
  select(where(is.numeric))

#selecting only character data 
penguins %>% 
  select(where(is.character))

######################################################
#mutate 
######################################################
#mutate  is used when we want to add a new column to the data set
#the new column is as a result of some mathematical calculation involving 
#existing columns

#sample_n(number) creates a random sample subset of the data 
penguins_subset <- penguins %>% 
  sample_n(15)

#convert the body mass from grams to kgs 
#1kg = 1000g
penguins_subset2 <- penguins_subset %>%
  mutate(body_weight_kgs = body_mass_g / 1000)


#the newly created column is automatically placed at the end of the data set
#we can move it to a place of our convenience. Eg at the beginning as shown.
#Everything() adds the rest of the columns.
penguins_subset2 %>% 
  select(body_weight_kgs, everything())


######################################################
#summarize/summarize
#####################################################
#summarize simply gives summaries of the numeric data . Eg, the mean or SD
#ensure the data doesn't have NAs. 
#we remove NAs using na.rm = TRUE
penguins_subset %>% 
  summarize(avg_flipper_length_mm = mean(flipper_length_mm, na.rm = TRUE))


#drop_na() also ignores the NAs but divides by the total number of observations
#counting even the one with NA. 
penguins_subset %>% 
  drop_na() %>% 
  summarize(avg_flipper_length = mean(flipper_length_mm))


#you get different answers when using drop_na and na.rm = TRUE.
#the summary() function gives the na.rm = TRUE answer. 


########################################################
      #group_by()
########################################################
#group_by() allows us to get quick summaries of groups of data

penguins_subset %>% 
  group_by(species) %>% 
  summarize(avg_body_mass = mean(body_mass_g, na.rm = TRUE))


########################################################
#pull()
########################################################
#Use pull() to extract a single column

penguins %>% 
  pull(sex)


#finding the number of distinct names, use n_distinct
n_distinct(penguins$island)




















