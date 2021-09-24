
##############################################################
#The Janitor package
##############################################################
#janitor package is used to clean dirty data 
#readxl package comes with function read_excel to read both xls and xlsx files.


#setting up enviroment
library(dplyr)
library(janitor)
library(readxl)

#importing the data
mymsa <- read_excel("mymsa.xlsx")


#####################################
#clean_names()
#####################################
#use clean_names() to make column names consistent
names(mymsa)
mymsa1 <- clean_names(mymsa)
names(mymsa1)

#####################################
#tabyl
#####################################

#tabyl takes a vector and returns a frequency table.
#it geta the number of unique values.
#it automatically calculates percentages of values in the column.
#it can optionally display NA values.
#
tabyl(mymsa1, meat_colour)

#we can format the percentage column using adorn_pct_formatting function

mymsa1 %>% 
  tabyl(meat_colour) %>% 
  adorn_pct_formatting(digits = 0, affix_sign = TRUE)


mymsa1 %>% 
  tabyl(spare)

#######################################
#remove_empty
#######################################
#remove_empty() removes columns that are entirely empty and rows too. 

mymsa2 <- mymsa1 %>% 
  remove_empty(which = c("rows","cols"))



#######################################
#cross tabulation
#######################################
#tabyl() function generalizes to cross tabulation of two or more variables
#look at the distribution of meat color over the two plants
#row totals
mymsa2 %>% 
  tabyl(meat_colour,plant) %>% 
  adorn_totals(where = "row")

mymsa2 %>% 
  tabyl(meat_colour,plant) %>% 
  adorn_totals(where = "col")




mymsa2 %>% 
  tabyl(meat_colour,plant) %>% 
  adorn_totals(where = c("row","col"))

#look at the distribution of meat color over two plants as percentages
mymsa2 %>% 
  tabyl(meat_colour, plant) %>% 
  adorn_totals(where = c("row","col")) %>% 
  adorn_percentages(denominator =  "col") %>% 
  adorn_pct_formatting(digits = 0)


#######################################
#get_dupes()
#######################################
#get_dupes() gets duplicates in columns 

#no duplicates are found in the rfid column
mymsa2 %>% 
  get_dupes(rfid)


########################################
#excel_numeric_to_date
########################################


#excel_numeric_to_date() converts numeric numbers in excel to dates 
excel_numeric_to_date(42223)

