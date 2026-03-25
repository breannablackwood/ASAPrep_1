#ASA Datafest Part 1 Prep 2026
#Created March 20, 2026 
#Reading in and Cleaning Data
#Breanna Blackwood & Anh Pham, UF Statistics Club

####Libraries
library(dplyr)

####Read in data files 
#I would recommend downloading it to your computer and reading it in. 
#This is easiest for me personally. 
data <- read.csv("Guetschow-et-al-2022-PRIMAP-hist_v2.4_11-Oct-2022.csv")
head(data, 1) #allows us to see the beginning n rows of the data. 

####Changing column names
#Notice that right now the column names sort of vary from the sheet.
#What if we want to make it the same? 
#We can do this using colnames
colnames(data) <- c("source", "scenario (PRIMAP-hist)", "area (ISO3)", "entity", 
                    "unit", "category (IPCC2006_PRIMAP)", 1750:2021)


####Subsetting columns 
#Now, let's say we want to only focus on certain columns of the data. 
#Then, we would want to create a new dataset that only has these columns.
#Now let's say we want to subset from 2000 to 2021. 
#We can do this by using the subset() command
data21century <- subset(data, select = c("source", "scenario (PRIMAP-hist)", "area (ISO3)", "entity", 
                                         "unit", "category (IPCC2006_PRIMAP)", 2000:2021))
head(data21century)

#Similarly, if you want to exclude some years like 2020, you can do this
data21centurywo20 <- subset(data, select = c("source", "scenario (PRIMAP-hist)", "area (ISO3)", "entity", 
                                             "unit", "category (IPCC2006_PRIMAP)", 2000:2019,2021))

####Subsetting rows
#But what if we want to do rows? 
#Let's say we want to only have the first 100 rows. 
data21first100 <- head(data21century, 100)
#But what if we want to get certain rows like row 50 to row 100?
#We can use slice() from the dplyr package, or base r functions 
data21row50to100 <- slice(data21century, (50:100))
#We can also specify with different slice function minimum values, maximum, etc. 
#Check the help pane for that information.

#If we want to subset by condition, we can use filter() from dplyr or base r functions 
#Let's say we want rows that have the entity CO2 only. 
data21CO2 <- filter(data21century, entity == "CO2")

####Getting rid of NA values 
#Okay. Let's suppose we want to remove all NA values from a dataset. 
#We can do this using na.omit
data21century <- na.omit(data21century) #Note this will remove any row that contains at least one NA value

#So we can see that removes all the rows and there is nothing left. 
#If we want to remove based on certain columns, we can use filter() instead or subset() 
#For example let's remove the rows with NA in 2000 or 2001 columns
clean2 <- filter(data21century,!is.na(`2000`) | !is.na(`2001`))
#Just make sure you use `` to specifies column name

####Piping
#Now if we want to get rows 100 to 1000, filter so where you can only have CO2, and filter out NA in 2000 or 2001
#We can utilize piping where this will be a lot more readable. There are 2 methods, %>% or |>
cleanfirstmethod <- data21century %>% slice((100:1000)) %>% filter(entity == "CO2") %>% filter(!is.na(`2000`) & !is.na(`2001`))
#Or we can also do this
cleansecondmethod <- data21century |> slice((100:1000)) |> filter(entity == "CO2") |> filter(!is.na(`2000`) & !is.na(`2001`))
#Piping essentially take an object and "pipe" it into the next function without saving the data set in each set to save memory
#Creating too much data sets in one environment can slow down the computer processing speed especially if it's multiple big data sets


####Transpose rows 
#Now let us find the mean of each unique area first from our data set in the year 2000 to 2021
MeanByArea <- clean2 %>% group_by(`area (ISO3)`) %>% summarise(across(any_of(as.character(2000:2021)), \(x) mean(x, na.rm = TRUE)))
#Since your area is unique, but your year is sequential, we should transpose this so that the unique area is your column header
transposed_matrix <- t(MeanByArea)
#Turn this into a data.frame
transposed_area <- as.data.frame(transposed_matrix)
#Now there's a convoluted way to make your first row as your header, but we will be employing janitor to help us out
library(janitor)
clean_transposed_area <- transposed_area %>% row_to_names(row_number = 1)
#And as usual, you can pipe all of the transposed process in one line like the following:
clean_transposed_area <- MeanByArea %>% t() %>% as.data.frame() %>% row_to_names(row_number = 1)
#Please note to still run the library or else the piping will not work

####Creating new variables/columns
#To create a new variable, we use the $ operator after the dataset.
#Let's say, just for fun we want to add a column that says "meow" in to our 21st century data.
data21century$cat <- "meow"
head(data21century)
#As we can see, the whole column is full of meows. 

####Bind columns and rows 
#Now let us have the following temporary data set
city_data <- data.frame(
  City = c("Tokyo", "New York", "London"),
  Population = c(37400000, 8400000, 8900000),
  Area_sqkm = c(2194, 783, 1572),
  GDP_Billion = c(1600, 1700, 978)
)

# 2. The single-row data frame (1 city, same 3 stats)
new_city <- data.frame(
  City = "Paris",
  Population = 2161000,
  Area_sqkm = 105,
  GDP_Billion = 850
)
#Now let's say we want to combine the row from new_city to existing city data, how would we go with this?
#We can do this by using the bind_rows()
city_data <- bind_rows(city_data,new_city)
#You can further sort the newly added row by alphabetical order by doing the following:
city_data <- city_data %>% arrange(City)
#If you need to sort the city first in descending order then population size, we can do this:
city_data <- city_data %>% arrange(desc(City), Population)
#Similarly, you can do the same thing with columns by doing bind_cols(), but make sure that your column name is case sensitive
#See help documentation for more information.

####Write out cleaned data to a csv. 
#To write out a csv, do the following: 
write.csv(city_data, file = "cleaned_city_data.csv")
#This will write out the data in the city_data to a .csv file in your wd with that name. 

####Final notes
#You can use base R commands to do some of these things, which is what I usually do. 
#But, using package commands may be helpful as well. 
#Ii would recommend also: tibble, tidyverse, and tinytex packages. 