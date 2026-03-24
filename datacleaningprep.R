#ASA Datafest Part 1 Prep 2026
#Created March 20, 2026 
#Reading in and Cleaning Data
#Breanna Blackwood & Anh Pham, UF Statistics Club

####Libraries
library(dplyr)

####Read in data files 
#I would recommend downloading it to your computer and reading it in. 
#This is easiest for me personally. 
data <- read.csv("~/Downloads/Guetschow-et-al-2022-PRIMAP-hist_v2.4_11-Oct-2022.csv")
head(data) #allows us to see the beginning rows of the data. 

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

####Subsetting rows
#But what if we want to do rows? 
#We can use slice() from the dplyr package, or base r functions 
#Let's say we want to only have the first 100 rows. 
data21first100 <- slice(data21century, (1:100))
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
clean2 <- data21century |>
  filter(!is.na(`2000`) & !is.na(`2001`))

####Transpose rows 


####Creating new variables/columns
#To create a new variable, we use the $ operator after the dataset.
#Let's say, just for fun we want to add a column that says "meow" in to our 21st century data.
data21century$cat <- "meow"
head(data21century)
#As we can see, the whole column is full of meows. 

####Bind columns and rows 
#This is helpful when combining rows and columns from different datasets. 
#We can do this by using the bind_rows() and bind_cols()
#See help documentation for more information.

####Write out cleaned data to a csv. 


####Final notes
#You can use base R commands to do some of these things, which is what I usually do. 
#But, using package commands may be helpful as well. 
#Ii would recommend also: tibble, tidyverse, and tinytex packages. 