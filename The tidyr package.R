#####################################################################
#TIDYR PACKAGE
######################################################################

library(tidyr)
library(readr)
library(dplyr)

#import the data set
gap_wide <- read_csv("gapminder_wide.csv") 


#explore the data set
str(gap_wide)
glimpse(gap_wide)

#########################################################
#pivot longer
#########################################################
gap_long <- gap_wide %>% 
  pivot_longer(
    cols = c(starts_with("pop"),
             starts_with("LifeExp"),
             starts_with("gdpPercap")),
    names_to = "obstype_year",
    values_to = "obs_value")
  
  
#############################################################
#separate
#############################################################
#the separate function is used to split character strings into
#multiple variables

#gap_long has the "obstype_year" with two separate data types that can be split
gap_long <- gap_long %>% 
  separate(obstype_year, into = c(
    "obstype", "year"),
    sep = "_")



############################################################
#gap_wider()
############################################################

gap_normal <- gap_long %>% 
  pivot_wider(names_from = obstype,
              values_from = obs_value)
