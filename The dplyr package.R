library(dplyr)
library(nycflights13)
glimpse(flights)

View(flights)


#######################################
#filter
######################################
#filter flights on Jan 1st
filter(flights, month == 1, day == 1)

#filter flights on Jan or Feb
filter(flights, month ==1 | month ==2)


########################################
#slice
#######################################
#to select rows by position, use slice()
slice(flights, 1:10)



#######################################
#arrange
#######################################
#arrange is used to reorder rows in ascending order
#add desc() to order rows in descending order

arrange(flights, year, month, day)


arrange(flights,desc(arr_delay))


########################################
#select
########################################
#select collumn namaes by name
select(flights, year, month, day)

#select all column names between origin and distance (inclusive)
select(flights, origin:distance)


#select all columns except those from year to day(inclusive)
select(flights, -(year:day))


##############################################
#rename
#############################################
#rename basically renames column names
names(flights)

#change tailnum to tail_num
flights1 <- flights %>% 
  rename(tail_num = tailnum)
names(flights1)

##############################################
#distinct
#############################################
#distinct finds unique values in a data table

distinct(flights, tailnum)
#find all unique origin/ destination pairs
distinct(flights, origin, dest)




##############################################
#mutate
#############################################
#mutate adds new columns that are functions of existing columns
mutate(flights,
       gain = arr_delay / dep_delay,
       speed = distance / air_time * 60)



#####################################################
#transmute
#####################################################

#if you only want to keep the new variable, use transmute
transmute(flights,
          gain = arr_delay - dep_delay,
          gain_per_hour = gain / (air_time / 60)
          )

#######################################################
#summarise()
######################################################
#summarise collapses a dataframe into a single row
summarise(
  flights,
  avg_delay = mean(dep_delay, na.rm = TRUE)
)
########################################################
#sample_n()   #sample_frac()
########################################################
#sample takes a random sample of rows
#sample_n() a fixed number
#sample_frac() a fixed fraction

sample_n(flights, 10)

smple_frac(flights, 0.01)




